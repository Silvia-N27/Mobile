import { AppDataSource } from "@shared/typeorm/data-source";
import RpgCharacter from "../typeorm/entities/RpgCharacter";
import AppError from "@shared/errors/AppError";

interface IRequest {
    name: string;
    characterClass: string;
    level: number;
    life: number;
    mana: number;
    strength: number;
}

export default class CreateCharacterService {
    public async execute({ name, characterClass, level, life, mana, strength }: IRequest): Promise<RpgCharacter> {
        const charactersRepository = AppDataSource.getRepository(RpgCharacter);

        const characterExists = await charactersRepository.findOne({
            where: { name }
        });

        if (characterExists) {
            throw new AppError("There is already one character with this name.");
        }

        const character = charactersRepository.create({
            name, characterClass, level, life, mana, strength
        });

        await charactersRepository.save(character);

        return character;
    }
}