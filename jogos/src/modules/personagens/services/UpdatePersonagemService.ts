import AppError from '@shared/errors/AppError';
import Personagem from '../typeorm/entities/Personagem';
import PersonagensRepository from '../typeorm/repositories/PersonagensRepository';
import JogosRepository from '@modules/jogos/typeorm/repositories/JogosRepository';

interface IRequest {
  id: string;
  jogo_id: string;
  nome: string;
  classe: string;
  habilidade_principal: string;
  nivel: number;
  tipo_personagem: string;
}

export default class UpdatePersonagemService {
  public async execute({
    id,
    jogo_id,
    nome,
    classe,
    habilidade_principal,
    nivel,
    tipo_personagem,
  }: IRequest): Promise<Personagem> {
    const personagensRepository = new PersonagensRepository();
    const jogosRepository = new JogosRepository();

    const personagem = await personagensRepository.findById(id);

    if (!personagem) {
      throw new AppError('Personagem não encontrado.');
    }

    const jogo = await jogosRepository.findById(jogo_id);

    if (!jogo) {
      throw new AppError('Jogo não encontrado.');
    }

    const personagemExists = await personagensRepository.findByNome(nome);

    if (personagemExists && personagemExists.id !== personagem.id) {
      throw new AppError('Já existe um personagem cadastrado com este nome.');
    }

    personagem.jogo_id = jogo_id;
    personagem.nome = nome;
    personagem.classe = classe;
    personagem.habilidade_principal = habilidade_principal;
    personagem.nivel = nivel;
    personagem.tipo_personagem = tipo_personagem;

    await personagensRepository.save(personagem);

    return personagem;
  }
}