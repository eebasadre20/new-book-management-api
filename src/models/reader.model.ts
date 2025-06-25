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

  @Column({ nullable: true })
  currentBookId: number; // New column to store the ID of the book currently being read

}
