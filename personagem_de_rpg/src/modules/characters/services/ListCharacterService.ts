import { AppDataSource } from "@shared/typeorm/data-source";
import RpgCharacter from "../typeorm/entities/RpgCharacter";

export default class ListCharacterService {
    public async execute(): Promise<RpgCharacter[]> {
        const charactersRepository = AppDataSource.getRepository(RpgCharacter);

        return charactersRepository.find();
    }
}