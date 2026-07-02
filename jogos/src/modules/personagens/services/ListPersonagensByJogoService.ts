import AppError from '@shared/errors/AppError';
import Personagem from '../typeorm/entities/Personagem';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';
import JogosRepository from '@modules/jogos/typeorm/repositories/JogosRepository';

interface IRequest {
  jogo_id: string;
}

export default class ListPersonagensByJogoService {
  public async execute({ jogo_id }: IRequest): Promise<Personagem[]> {
    const personagensRepository = new PersonagensRepository();
    const jogosRepository = new JogosRepository();

    const jogo = await jogosRepository.findById(jogo_id);

    if (!jogo) {
      throw new AppError('Jogo não encontrado.');
    }

    const personagens = await personagensRepository.findByJogoId(jogo_id);

    return personagens;
  }
}