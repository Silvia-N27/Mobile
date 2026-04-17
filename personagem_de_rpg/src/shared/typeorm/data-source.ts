import "reflect-metadata";
import { DataSource } from "typeorm";
import path from "path";

export const AppDataSource = new DataSource({
  type: "postgres",
  host: "localhost",
  port: 5433,
  username: "postgres",
  password: "docker",
  database: "personagem_rpg",
  synchronize: false,
  logging: true,
  entities: [],
  migrations: [path.join("src", "shared", "migrations", "*.ts")],
});