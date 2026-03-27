import path from "node:path";
import { DataSource } from "typeorm";

export const AppDataSource = new DataSource({
    type: "postgres",
    host: "localhost",
    port: 5433, //5432 se nao tiver o postgres instalado
    username: "postgres",
    password: "docker",
    database: "apivendas",
    synchronize: false,
    logging: true,
    entities: [],
    migrations: [path.join(__dirname, "migrations", "*.ts")]
});