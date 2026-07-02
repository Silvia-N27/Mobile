import { NextFunction, Request, Response } from 'express';
import CreateSessionsService from '../services/CreateSessionsService';

export default class SessionsController {
  public async create(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const { email, password } = request.body;

      const createSession = new CreateSessionsService();

      const { user, token } = await createSession.execute({
        email,
        password,
      });

      delete (user as any).password;

      return response.json({
        user,
        token,
      });
    } catch (err) {
      next(err);
    }
  }
}