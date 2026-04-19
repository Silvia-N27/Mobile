import "reflect-metadata";
import { DataSource } from "typeorm";
import path from "path";
import RpgCharacter from "@modules/characters/typeorm/entities/RpgCharacter";

export const AppDataSource = new DataSource({
  type: "postgres",
  host: "localhost",
  port: 5433,
  username: "postgres",
  password: "docker",
  database: "personagem_rpg",
  synchronize: false,
  logging: true,
  entities: [RpgCharacter],
  migrations: [path.join("src", "shared", "typeorm", "migrations", "*.ts")],
});