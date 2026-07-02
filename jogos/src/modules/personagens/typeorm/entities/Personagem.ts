import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

import Jogo from '@modules/jogos/typeorm/entities/Jogo';

@Entity('personagens')
export default class Personagem {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  jogo_id: string;

  @ManyToOne(() => Jogo)
  @JoinColumn({ name: 'jogo_id' })
  jogo: Jogo;

  @Column()
  nome: string;

  @Column()
  classe: string;

  @Column()
  habilidade_principal: string;

  @Column('int')
  nivel: number;

  @Column()
  tipo_personagem: string;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;
}