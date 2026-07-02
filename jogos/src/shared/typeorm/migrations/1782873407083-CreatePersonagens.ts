import { MigrationInterface, QueryRunner } from "typeorm";

export class CreatePersonagens1782873407083 implements MigrationInterface {
    name = 'CreatePersonagens1782873407083'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "personagens" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "jogo_id" uuid NOT NULL, "nome" character varying NOT NULL, "classe" character varying NOT NULL, "habilidade_principal" character varying NOT NULL, "nivel" integer NOT NULL, "tipo_personagem" character varying NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_8adef6c19a5fbe0f01f2b4e72c4" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "personagens" ADD CONSTRAINT "FK_411298a10602c19408b73b2ef20" FOREIGN KEY ("jogo_id") REFERENCES "jogos"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "personagens" DROP CONSTRAINT "FK_411298a10602c19408b73b2ef20"`);
        await queryRunner.query(`DROP TABLE "personagens"`);
    }

}
