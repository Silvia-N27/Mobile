import Personagem from '../typeorm/entities/Personagem';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';

export default class ListPersonagensService {
  public async execute(): Promise<Personagem[]> {
    const personagensRepository = new PersonagensRepository();

    const personagens = await personagensRepository.findAll();

    return personagens;
  }
}