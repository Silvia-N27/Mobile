import { Repository } from 'typeorm';
import { AppDataSource } from '@shared/typeorm/data-source';
import Jogo from '../entities/Jogo';

export default class JogosRepository {
    private ormRepository: Repository<Jogo>;

    constructor() {
        this.ormRepository = AppDataSource.getRepository(Jogo);
    }

    public async findAll(): Promise<Jogo[]> {
        return this.ormRepository.find();
    }

    public async findById(id: string): Promise<Jogo | null> {
        return this.ormRepository.findOne({
            where: { id },
        });
    }

    public async findByTitulo(titulo: string): Promise<Jogo | null> {
        return this.ormRepository.findOne({
            where: { titulo },
        });
    }

    public async createJogo(data: Partial<Jogo>): Promise<Jogo> {
        const jogo = this.ormRepository.create(data);

        await this.ormRepository.save(jogo);

        return jogo;
    }

    public async save(jogo: Jogo): Promise<Jogo> {
        return this.ormRepository.save(jogo);
    }

    public async remove(jogo: Jogo): Promise<void> {
        await this.ormRepository.remove(jogo);
    }
}