import { Router } from 'express';
import { celebrate, Joi, Segments } from 'celebrate';
import JogosController from '../controllers/JogosController';
import isAuthenticated from '@shared/http/middlewares/isAuthenticated';

const jogosRouter = Router();
const jogosController = new JogosController();

jogosRouter.use(isAuthenticated);

jogosRouter.get('/', async (req, res, next) => {
  try {
    await jogosController.index(req, res, next);
  } catch (err) {
    next(err);
  }
});

jogosRouter.get(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await jogosController.show(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

jogosRouter.post(
  '/',
  celebrate({
    [Segments.BODY]: {
      titulo: Joi.string().required(),
      genero: Joi.string().required(),
      plataforma: Joi.string().required(),
      desenvolvedora: Joi.string().required(),
      ano_lancamento: Joi.number().integer().required(),
      classificacao_indicativa: Joi.string().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await jogosController.create(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

jogosRouter.put(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
    [Segments.BODY]: {
      titulo: Joi.string().required(),
      genero: Joi.string().required(),
      plataforma: Joi.string().required(),
      desenvolvedora: Joi.string().required(),
      ano_lancamento: Joi.number().integer().required(),
      classificacao_indicativa: Joi.string().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await jogosController.update(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

jogosRouter.delete(
  '/:id',
  celebrate({
    [Segments.PARAMS]: {
      id: Joi.string().uuid().required(),
    },
  }),
  async (req, res, next) => {
    try {
      await jogosController.delete(req, res, next);
    } catch (err) {
      next(err);
    }
  },
);

export default jogosRouter;