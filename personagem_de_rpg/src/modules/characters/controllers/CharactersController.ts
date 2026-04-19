import { NextFunction, Request, Response } from "express";
import ListCharacterService from "../services/ListCharacterService";
import ShowCharacterService from "../services/ShowCharacterService";
import CreateCharacterService from "../services/CreateCharacterService";
import UpdateCharacterService from "../services/UpdateCharacterService";
import DeleteCharacterService from "../services/DeleteCharacterService";

export default class CharactersController {
    public async index(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
        try {
            const listCharacters = new ListCharacterService();

            const characters = await listCharacters.execute();

            return response.json(characters);
        } catch (err) {
            next(err);
        }
    }

    public async show(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
        try {
            const id = request.params.id as string;

            const showCharacter = new ShowCharacterService();

            const character = await showCharacter.execute({ id });

            return response.json(character);
        } catch (err) {
            next(err);
        }
    }

    public async create(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
        try {
            const { name, characterClass, level, life, mana, strength } = request.body;

            const createCharacter = new CreateCharacterService();

            const character = await createCharacter.execute({
                name, characterClass, level, life, mana, strength
            })

            return response.status(201).json(character);
        } catch (err) {
            next(err);
        }
    }

    public async update(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
        try {
            const id = request.params.id as string;

            const { name, characterClass, level, life, mana, strength } = request.body;

            const updateCharacter = new UpdateCharacterService();

            const character = await updateCharacter.execute({
                id, name, characterClass, level, life, mana, strength
            })

            return response.json(character);
        } catch (err) {
            next(err);
        }
    }

    public async delete(request: Request, response: Response, next: NextFunction): Promise<Response | void> {
        try {
            const id = request.params.id as string;

            const deleteCharacter = new DeleteCharacterService();

            await deleteCharacter.execute({ id });

            return response.status(204).send();
        } catch (err) {
            next(err);
        }
    }

}