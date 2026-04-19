import { Router } from "express";
import CharactersController from "../controllers/CharactersController";
import { celebrate, Joi, Segments } from "celebrate";

const charactersRouter = Router();
const charactersController = new CharactersController();

charactersRouter.get("/", async (req, res, next) => {
    try {
        await charactersController.index(req, res, next);
    } catch (err) {
        next(err);
    }
});

charactersRouter.get("/:id", celebrate({
    [Segments.PARAMS]: {
        id: Joi.string().uuid().required(),
    },
}),
async (req, res, next) => {
    try {
        await charactersController.show(req, res, next);
    } catch (err) {
        next(err);
    }
});

charactersRouter.post("/", celebrate({
    [Segments.BODY]: {
        name: Joi.string().required(),
        characterClass: Joi.string().required(),
        level: Joi.number().min(0).required(),
        life: Joi.number().min(0).required(),
        mana: Joi.number().min(0).required(),
        strength: Joi.number().min(0).required(),
    }
}),
async (req, res, next) => {
    try {
        await charactersController.create(req, res, next);
    } catch (err) {
        next(err);
    }
});

charactersRouter.put("/:id", celebrate({
    [Segments.PARAMS]: {
        id: Joi.string().uuid().required(),
    },
    [Segments.BODY]: {
        name: Joi.string().required(),
        characterClass: Joi.string().required(),
        level: Joi.number().min(0).required(),
        life: Joi.number().min(0).required(),
        mana: Joi.number().min(0).required(),
        strength: Joi.number().min(0).required(),
    }
}),
async (req, res, next) => {
    try {
        await charactersController.update(req, res, next);
    } catch (err) {
        next(err);
    }
});

charactersRouter.delete("/:id", celebrate({
    [Segments.PARAMS]: {
        id: Joi.string().uuid().required(),
    },
}),
async (req, res, next) => {
    try {
        await charactersController.delete(req, res, next);
    } catch (err) {
        next(err);
    }
});

export default charactersRouter;