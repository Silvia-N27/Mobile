import Personagem from '@modules/personagens/typeorm/entities/Personagem';

import {
    Column,
    CreateDateColumn,
    Entity,
    OneToMany,
    PrimaryGeneratedColumn,
    UpdateDateColumn,
} from 'typeorm';

@Entity('jogos')
export default class Jogo {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    titulo: string;

    @Column()
    genero: string;

    @Column()
    plataforma: string;

    @Column()
    desenvolvedora: string;

    @Column('int')
    ano_lancamento: number;

    @Column()
    classificacao_indicativa: string;

    @OneToMany(() => Personagem, personagem => personagem.jogo)
    personagens: Personagem[];

    @CreateDateColumn()
    created_at: Date;

    @UpdateDateColumn()
    updated_at: Date;
}