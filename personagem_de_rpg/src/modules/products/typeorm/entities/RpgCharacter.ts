import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('characters')
export default class RpgCharacter {
  @PrimaryGeneratedColumn('uuid')
  id: string;
  @Column()
  name: string;
  @Column()
  characterClass: string;
  @Column('int')
  level: number;
  @Column('int')
  life: number;
  @Column('int')
  mana: number;
  @Column('int')
  strength: number;
  @CreateDateColumn()
  created_at: Date;
  @UpdateDateColumn()
  updated_at: Date;
}