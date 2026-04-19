import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateCharacters1776463328998 implements MigrationInterface {
    name = 'CreateCharacters1776463328998'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "characters" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "name" character varying NOT NULL, "characterClass" character varying NOT NULL, "level" integer NOT NULL, "life" integer NOT NULL, "mana" integer NOT NULL, "strength" integer NOT NULL, "created_at" TIMESTAMP NOT NULL DEFAULT now(), "updated_at" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_9d731e05758f26b9315dac5e378" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "characters"`);
    }

}
