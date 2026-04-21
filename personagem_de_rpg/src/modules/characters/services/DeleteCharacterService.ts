import { AppDataSource } from "@shared/typeorm/data-source";
import RpgCharacter from "../typeorm/entities/RpgCharacter";
import AppError from "@shared/errors/AppError";

interface IRequest {
  id: string;
}

export default class DeleteCharacterService {
  public async execute({ id }: IRequest): Promise<void> {
    const charactersRepository = AppDataSource.getRepository(RpgCharacter);

    const character = await charactersRepository.findOne({
      where: { id }
    });

    if (!character) {
      throw new AppError("Character not found.");
    }

    await charactersRepository.remove(character);
  }
}