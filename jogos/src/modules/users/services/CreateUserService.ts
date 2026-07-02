import { hash } from 'bcryptjs';
import AppError from '@shared/errors/AppError';
import User from '../typeorm/entities/User';
import UsersRepository from '../typeorm/repositories/UsersRepository';

interface IRequest {
    name: string;
    email: string;
    password: string;
}

export default class CreateUserService {
    public async execute({ name, email, password }: IRequest): Promise<User> {
        const usersRepository = new UsersRepository();

        const emailExists = await usersRepository.findByEmail(email);

        if (emailExists) {
            throw new AppError('Este e-mail já está sendo utilizado.');
        }

        const hashedPassword = await hash(password, 8);

        const user = await usersRepository.createUser({
            name,
            email,
            password: hashedPassword,
        });

        return user;
    }
}