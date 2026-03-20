import { Cliente } from "./cliente";
import { Produto } from "./produto";

export class Venda {
    _codigo: number;
    _data: string;
    _cliente : Cliente;
    _produtos: Produto[];

    constructor(codigo: number, data: string, cliente: Cliente, produtos: Produto[]) {
        this._codigo = codigo;
        this._data = data;
        this._cliente = cliente;
        this._produtos = produtos;
    }

    get codigo(): number {
        return this._codigo;
    }

    set codigo(codigo: number) {
        this._codigo = codigo;
    }

    get data(): string {
        return this._data;
    }

    set data(data: string) {
        this._data = data;
    }

    get cliente(): Cliente {
        return this._cliente;
    }

    set cliente(cliente: Cliente) {
        this._cliente = cliente;
    }

    get produtos(): Produto[] {
        return this._produtos;
    }

    set produtos(produtos: Produto[]) {
        this._produtos = produtos;
    }

    calcularTotal(): number {
        let total = 0;

        for(const i of this._produtos) {
            total += i.valor;
        }

        return total;
    }
}
