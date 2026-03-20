const disciplina: string = "Desenvolvimento de Sistemas Web";
console.log(disciplina);

import { Endereco } from "./endereco";
import { Telefone } from "./telefone";
import { Cliente } from "./cliente";
import { Produto } from "./produto";
import { Venda } from "./venda";

const endereco = new Endereco("Rua tal", 116, "Rio de Janeiro", "RJ");

const t1 = new  Telefone("21", "989875787", "celular");
const t2 = new Telefone("42", "998675434", "celular");

const cliente = new Cliente(
    "Liedso",
    "14233345678",
    "04/03/2008",
    "Masculino",
    endereco,
    [t1,t2]
);

const p1 = new Produto(1, "Anel", 50);
const p2 = new Produto(2, "Rx 7800 xt", 1882.34);
const p3 = new Produto(3, "Passatempo de chocolate", 3.50);

const venda = new Venda(100, "20/03/2006", cliente, [p1,p2,p3]);

console.log("Cliente:", venda.cliente.nome);
console.log("Cidade:", venda.cliente.endereco);
console.log("Total:", venda.calcularTotal());