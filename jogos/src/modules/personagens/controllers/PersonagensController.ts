import { NextFunction, Request, Response } from 'express';
import CreatePersonagemService from '../services/CreatePersonagemService';
import ListPersonagensService from '../services/ListPersonagensService';
import ShowPersonagemService from '../services/ShowPersonagemService';
import UpdatePersonagemService from '../services/UpdatePersonagemService';
import DeletePersonagemService from '../services/DeletePersonagemService';
import ListPersonagensByJogoService from '../services/ListPersonagensByJogoService';

export default class PersonagensController {
  public async index(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const listPersonagens = new ListPersonagensService();

      const personagens = await listPersonagens.execute();

      return response.json(personagens);
    } catch (err) {
      next(err);
    }
  }

  public async show(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const id = request.params.id as string;

      const showPersonagem = new ShowPersonagemService();

      const personagem = await showPersonagem.execute({ id });

      return response.json(personagem);
    } catch (err) {
      next(err);
    }
  }

  public async create(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const {
        jogo_id,
        nome,
        classe,
        habilidade_principal,
        nivel,
        tipo_personagem,
      } = request.body;

      const createPersonagem = new CreatePersonagemService();

      const personagem = await createPersonagem.execute({
        jogo_id,
        nome,
        classe,
        habilidade_principal,
        nivel,
        tipo_personagem,
      });

      return response.status(201).json(personagem);
    } catch (err) {
      next(err);
    }
  }

  public async update(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const id = request.params.id as string;

      const {
        jogo_id,
        nome,
        classe,
        habilidade_principal,
        nivel,
        tipo_personagem,
      } = request.body;

      const updatePersonagem = new UpdatePersonagemService();

      const personagem = await updatePersonagem.execute({
        id,
        jogo_id,
        nome,
        classe,
        habilidade_principal,
        nivel,
        tipo_personagem,
      });

      return response.json(personagem);
    } catch (err) {
      next(err);
    }
  }

  public async delete(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const id = request.params.id as string;

      const deletePersonagem = new DeletePersonagemService();

      await deletePersonagem.execute({ id });

      return response.status(204).send();
    } catch (err) {
      next(err);
    }
  }

  public async listByJogo(
    request: Request,
    response: Response,
    next: NextFunction,
  ): Promise<Response | void> {
    try {
      const jogo_id = request.params.jogo_id as string;

      const listPersonagensByJogo = new ListPersonagensByJogoService();

      const personagens = await listPersonagensByJogo.execute({ jogo_id });

      return response.json(personagens);
    } catch (err) {
      next(err);
    }
  }
}