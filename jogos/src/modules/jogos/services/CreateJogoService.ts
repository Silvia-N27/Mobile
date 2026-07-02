import AppError from '@shared/errors/AppError';
import Jogo from '../typeorm/entities/Jogo';
import JogosRepository from '../typeorm/repositories/JogosRepository';

interface IRequest {
    titulo: string;
    genero: string;
    plataforma: string;
    desenvolvedora: string;
    ano_lancamento: number;
    classificacao_indicativa: string;
}

export default class CreateJogoService {
    public async execute({
        titulo,
        genero,
        plataforma,
        desenvolvedora,
        ano_lancamento,
        classificacao_indicativa,
    }: IRequest): Promise<Jogo> {
        const jogosRepository = new JogosRepository();

        const jogoExists = await jogosRepository.findByTitulo(titulo);

        if (jogoExists) {
            throw new AppError('Já existe um jogo cadastrado com este título.');
        }

        const jogo = await jogosRepository.createJogo({
            titulo,
            genero,
            plataforma,
            desenvolvedora,
            ano_lancamento,
            classificacao_indicativa,
        });

        return jogo;
    }
}