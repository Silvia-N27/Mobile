import { Router } from 'express';
import jogosRouter from '@modules/jogos/routes/jogos.routes';
import personagensRouter from '@modules/personagens/routes/personagens.routes';
import usersRouter from '@modules/users/routes/users.routes';
import sessionsRouter from '@modules/users/routes/sessions.routes';

const routes = Router();

routes.use('/jogos', jogosRouter);
routes.use('/personagens', personagensRouter);
routes.use('/users', usersRouter);
routes.use('/sessions', sessionsRouter);

routes.get('/', (request, response) => {
  return response.json({
    message: 'API Jogos e Personagens funcionando!',
  });
});

export default routes;