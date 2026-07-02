import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateJogos1782862637772 implements MigrationInterface {
    name = 'CreateJogos1782862637772'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "jogos" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "titulo" character varying NOT NULL, "genero" character varying NOT NULL, "plataforma" character varying NOT NULL, "desenvolvedora" character varying NOT NULL, "ano_lancamento" integer NOT NULL, "classificacao_indicativa" character varying NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_7312a4a154694e761783f910223" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "jogos"`);
    }

}
