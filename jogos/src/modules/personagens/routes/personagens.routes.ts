import { Router } from 'express';
import { celebrate, Joi, Segments } from 'celebrate';
import PersonagensController from '../controllers/PersonagensController';
import isAuthenticated from '@shared/http/middlewares/isAuthenticated';

const personagensRouter = Router();
const personagensController = new PersonagensController();

personagensRouter.use(isAuthenticated);

personagensRouter.get('/', async (req, res, next) => {
  try {
    await personagensController.index(req, res, next);
  } catch (err) {
    next(err);
  }
});

personagensRouter.get(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await personagensController.show(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

personagensRouter.post(
  '/',
  celebrate({
    [Segments.BODY]: {
      jogo_id: Joi.string().uuid().required(),
      nome: Joi.string().required(),
      classe: Joi.string().required(),
      habilidade_principal: Joi.string().required(),
      nivel: Joi.number().integer().min(1).required(),
      tipo_personagem: Joi.string().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await personagensController.create(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

personagensRouter.put(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
    [Segments.BODY]: {
      jogo_id: Joi.string().uuid().required(),
      nome: Joi.string().required(),
      classe: Joi.string().required(),
      habilidade_principal: Joi.string().required(),
      nivel: Joi.number().integer().min(1).required(),
      tipo_personagem: Joi.string().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await personagensController.update(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

personagensRouter.delete(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await personagensController.delete(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

personagensRouter.get(
  '/jogo/:jogo_id/listar',
  celebrate({
    [Segments.PARAMS]: {
      jogo_id: Joi.string().uuid().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await personagensController.listByJogo(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

export default personagensRouter;