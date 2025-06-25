import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Reader {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 100 })
  name: string;

  @Column()
  email: string;

  @Column({ nullable: true })
  age: number;
}
