import User from '../typeorm/entities/User';
import UsersRepository from '../typeorm/repositories/UsersRepository';

export default class ListUsersService {
  public async execute(): Promise<User[]> {
    const usersRepository = new UsersRepository();

    const users = await usersRepository.findAll();

    return users;
  }
}