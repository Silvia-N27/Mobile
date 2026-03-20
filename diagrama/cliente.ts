import { Endereco } from "./endereco";
import { Telefone } from "./telefone";

export class Cliente {
    _nome: string;
    _cpf: string;
    _data_nascimento: string;
    _genero: string;
    _endereco: Endereco;
    _telefones: Telefone[];

    constructor(nome: string, cpf: string, data_nascimento: string, genero: string, endereco: Endereco, telefones: Telefone[]){
        this._nome = nome;
        this._cpf = cpf;
        this._data_nascimento = data_nascimento;
        this._genero = genero;
        this._endereco = endereco;
        this._telefones = telefones;
    }

    get nome(): string {
        return this._nome;
    }

    set nome(nome: string) {
        this._nome = nome;
    }

    get cpf(): string {
        return this._cpf;
    }

    set cpf(cpf: string) {
        this._cpf = cpf;
    }

    get data_nascimento(): string {
        return this._data_nascimento;
    }

    set data_nascimento(data_nascimento: string) {
        this._data_nascimento = data_nascimento;
    }

    get genero(): string {
        return this._genero;
    }

    set genero(genero: string) {
        this._genero = genero;
    }

    get endereco(): Endereco {
        return this._endereco;
    }

    set endereco(endereco: Endereco) {
        this._endereco = endereco;
    }

    get telefones(): Telefone[] {
        return this._telefones;
    }

    set telefones(telefones: Telefone[]) {
        this._telefones = telefones;
    }

}