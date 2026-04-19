import charactersRouter from "@modules/characters/routes/characters.routes";
import { Router } from "express";

const routes = Router();

routes.use("/characters", charactersRouter);

routes.get('/', (request, response) => {
    response.json({ message: 'Hello Dev!' });
    return;
});

export default routes;