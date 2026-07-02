import AppError from '@shared/errors/AppError';
import Personagem from '../typeorm/entities/Personagem';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';
import JogosRepository from '@modules/jogos/typeorm/repositories/JogosRepository';

interface IRequest {
  jogo_id: string;
  nome: string;
  classe: string;
  habilidade_principal: string;
  nivel: number;
  tipo_personagem: string;
}

export default class CreatePersonagemService {
  public async execute({
    jogo_id,
    nome,
    classe,
    habilidade_principal,
    nivel,
    tipo_personagem,
  }: IRequest): Promise<Personagem> {
    const personagensRepository = new PersonagensRepository();
    const jogosRepository = new JogosRepository();

    const jogo = await jogosRepository.findById(jogo_id);

    if (!jogo) {
      throw new AppError('Jogo não encontrado.');
    }

    const personagemExists = await personagensRepository.findByNome(nome);

    if (personagemExists) {
      throw new AppError('Já existe um personagem cadastrado com este nome.');
    }

    const personagem = await personagensRepository.createPersonagem({
      jogo_id,
      nome,
      classe,
      habilidade_principal,
      nivel,
      tipo_personagem,
    });

    return personagem;
  }
}