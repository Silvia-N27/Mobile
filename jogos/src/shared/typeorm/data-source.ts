import 'reflect-metadata';
import { DataSource } from 'typeorm';
import path from 'path';
import Jogo from '@modules/jogos/typeorm/entities/Jogo';
import Personagem from '@modules/personagens/typeorm/entities/Personagem';
import User from '@modules/users/typeorm/entities/User';

export const AppDataSource = new DataSource({
    type: 'postgres',
    host: 'localhost',
    port: 5433,
    username: 'postgres',
    password: 'docker',
    database: 'api_jogos_personagens',
    synchronize: false,
    logging: true,
    entities: [Jogo, Personagem, User],
    migrations: [path.join("src", "shared", "typeorm", "migrations", "*.ts")]
});