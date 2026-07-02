import AppError from '@shared/errors/AppError';
import Jogo from '../typeorm/entities/Jogo';
import JogosRepository from '../typeorm/repositories/JogosRepository';

interface IRequest {
  id: string;
  titulo: string;
  genero: string;
  plataforma: string;
  desenvolvedora: string;
  ano_lancamento: number;
  classificacao_indicativa: string;
}

export default class UpdateJogoService {
  public async execute({
    id,
    titulo,
    genero,
    plataforma,
    desenvolvedora,
    ano_lancamento,
    classificacao_indicativa,
  }: IRequest): Promise<Jogo> {
    const jogosRepository = new JogosRepository();

    const jogo = await jogosRepository.findById(id);

    if (!jogo) {
      throw new AppError('Jogo não encontrado.');
    }

    const jogoExists = await jogosRepository.findByTitulo(titulo);

    if (jogoExists && jogoExists.id !== jogo.id) {
      throw new AppError('Já existe um jogo cadastrado com este título.');
    }

    jogo.titulo = titulo;
    jogo.genero = genero;
    jogo.plataforma = plataforma;
    jogo.desenvolvedora = desenvolvedora;
    jogo.ano_lancamento = ano_lancamento;
    jogo.classificacao_indicativa = classificacao_indicativa;

    await jogosRepository.save(jogo);

    return jogo;
  }
}