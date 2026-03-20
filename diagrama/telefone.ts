export class Telefone {
    _ddd: string;
    _numero: string;
    _tipo: string;

    constructor(ddd: string, numero: string, tipo: string) {
        this._ddd = ddd;
        this._numero = numero;
        this._tipo = tipo;
    }

    get ddd(): string {
        return this._ddd;
    }

    set ddd(ddd: string) {
        this._ddd = ddd;
    }

    get numero(): string {
        return this._numero;
    }

    set numero(numero: string) {
        this._numero = numero;
    }

    get tipo(): string {
        return this._tipo;
    }

    set tipo(tipo: string) {
        this._tipo = tipo;
    }
}