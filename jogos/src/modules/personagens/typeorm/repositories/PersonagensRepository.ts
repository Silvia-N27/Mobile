import { Repository } from 'typeorm';
import { AppDataSource } from '@shared/typeorm/data-source';
import Personagem from '../entities/Personagem';

export default class PersonagensRepository {
    private ormRepository: Repository<Personagem>;

    constructor() {
        this.ormRepository = AppDataSource.getRepository(Personagem);
    }

    public async findAll(): Promise<Personagem[]> {
        return this.ormRepository.find({
            relations: {
                jogo: true,
            },
        });
    }

    public async findById(id: string): Promise<Personagem | null> {
        return this.ormRepository.findOne({
            where: { id },
            relations: {
                jogo: true,
            },
        });
    }

    public async findByNome(nome: string): Promise<Personagem | null> {
        return this.ormRepository.findOne({
            where: { nome },
        });
    }

    public async findByJogoId(jogo_id: string): Promise<Personagem[]> {
        return this.ormRepository.find({
            where: { jogo_id },
            relations: {
                jogo: true,
            },
        });
    }

    public async createPersonagem(data: Partial<Personagem>): Promise<Personagem> {
        const personagem = this.ormRepository.create(data);

        await this.ormRepository.save(personagem);

        return personagem;
    }

    public async save(personagem: Personagem): Promise<Personagem> {
        return this.ormRepository.save(personagem);
    }

    public async remove(personagem: Personagem): Promise<void> {
        await this.ormRepository.remove(personagem);
    }
}