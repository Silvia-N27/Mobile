import { Repository } from "typeorm";
import RpgCharacter from "../entities/RpgCharacter";
import { AppDataSource } from "@shared/typeorm/data-source";

export default class CharactersRepository{
    private ormRepository: Repository <RpgCharacter>;

    constructor() {
        this.ormRepository = AppDataSource.getRepository(RpgCharacter);
    }

    public async findByName(name: string): Promise<RpgCharacter | null>{
        const character = await this.ormRepository.findOne({
            where: {name},
        });

        return character;
    }
}