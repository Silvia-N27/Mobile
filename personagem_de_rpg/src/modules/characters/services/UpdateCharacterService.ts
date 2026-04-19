import { AppDataSource } from "@shared/typeorm/data-source";
import RpgCharacter from "../typeorm/entities/RpgCharacter";
import AppError from "@shared/errors/AppError";

interface IRequest {
  id: string;
  name: string;
  characterClass: string;
  level: number;
  life: number;
  mana: number;
  strength: number;
}

export default class UpdateCharacterService {
  public async execute({
    id,
    name,
    characterClass,
    level,
    life,
    mana,
    strength,
  }: IRequest): Promise<RpgCharacter> {
    const charactersRepository = AppDataSource.getRepository(RpgCharacter);

    const character = await charactersRepository.findOne({
      where: { id },
    });

    if (!character) {
      throw new AppError("Character not found.");
    }

    const characterExists = await charactersRepository.findOne({
      where: { name },
    });

    if (characterExists && characterExists.id !== id) {
      throw new AppError("There is already one character with this name.");
    }

    character.name = name;
    character.characterClass = characterClass;
    character.level = level;
    character.life = life;
    character.mana = mana;
    character.strength = strength;

    await charactersRepository.save(character);

    return character;
  }
}