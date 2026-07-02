import AppError from '@shared/errors/AppError';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';

interface IRequest {
  id: string;
}

export default class DeletePersonagemService {
  public async execute({ id }: IRequest): Promise<void> {
    const personagensRepository = new PersonagensRepository();

    const personagem = await personagensRepository.findById(id);

    if (!personagem) {
      throw new AppError('Personagem não encontrado.');
    }

    await personagensRepository.remove(personagem);
  }
}