resource "aws_ecs_cluster" "this" {
  name               = var.name
  configuration {
    execute_command_configuration {
      kms_key_id = var.ecs_exec_kms_arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name = var.cloudwatch_log_group_ecs_exec_name
        s3_bucket_name             = var.ecs_exec_s3_bucket_name
        s3_key_prefix              = "exec-output"
      }
    }
  }
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
  tags = {
    Terraform = "true"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 1
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "nestjs"
  network_mode             = "awsvpc"
  task_role_arn            = var.iam_arn
  execution_role_arn       = var.iam_arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<EOF
[
  {
    "name": "nestjs",
    "image": "${var.image_url}:latest",
    "essential": true,
    "command": ["yarn", "start"],
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "environment": ${jsonencode(local.environment)},
    "secrets": ${jsonencode(local.secrets)},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-northeast-1",
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-stream-prefix": "nestjs"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "web" {
  name                               = "${var.name}_api"
  task_definition                    = aws_ecs_task_definition.web.arn
  cluster                            = aws_ecs_cluster.this.id
  desired_count                      = 1
  health_check_grace_period_seconds  = 120
  enable_ecs_managed_tags            = true
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  scheduling_strategy                = "REPLICA"
  enable_execute_command             = true

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
    base              = 0
  }

  load_balancer {
    target_group_arn = var.lb_blue_arn
    container_name   = "nestjs"
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      load_balancer,
      capacity_provider_strategy
    ]
  }
}

# standalone task with no service
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_run_task.html
resource "aws_ecs_task_definition" "db_setup" {
  task_role_arn            = var.iam_arn
  family                   = "${var.name}_db_setup"
  network_mode             = "awsvpc"
  execution_role_arn       = var.iam_arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  container_definitions    = <<EOF
  [
  {
    "name": "${var.name}_db_setup",
    "image": "${var.image_url}:latest",
    "essential": true,
    "command": ["yarn", "db:run"],
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 22,
        "hostPort": 22
      }
    ],
    "environment": ${jsonencode(local.environment)},
    "secrets": ${jsonencode(local.secrets)},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-northeast-1",
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-stream-prefix": "${var.name}_db_setup"
      }
    },
    "awsvpcConfiguration": {
      "subnets": "${var.subnets[0]}",
      "securityGroups": "${var.security_groups[0]}",
      "assignPublicIp": "ENABLED"
    }
  }
  ]
  EOF
}