import Jogo from '../typeorm/entities/Jogo';
import JogosRepository from '../typeorm/repositories/JogosRepository';

export default class ListJogosService {
  public async execute(): Promise<Jogo[]> {
    const jogosRepository = new JogosRepository();

    const jogos = await jogosRepository.findAll();

    return jogos;
  }
}