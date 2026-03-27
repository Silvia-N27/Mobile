import {response, Router} from "express";
import { request } from "node:http";

const routes = Router();

routes.get('/',(request, response)=>{ //resquest pega response recebe resposta
    response.json({message: 'Hello dev'});
    return;
})

export default routes;