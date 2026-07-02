import AppError from '@shared/errors/AppError';
import Personagem from '../typeorm/entities/Personagem';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';

interface IRequest {
  id: string;
}

export default class ShowPersonagemService {
  public async execute({ id }: IRequest): Promise<Personagem> {
    const personagensRepository = new PersonagensRepository();

    const personagem = await personagensRepository.findById(id);

    if (!personagem) {
      throw new AppError('Personagem não encontrado.');
    }

    return personagem;
  }
}