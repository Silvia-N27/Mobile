enum Tipo {
  maior,menor
}

class Pessoa {
  String nome;
  int idade;
  Tipo tipo;
  Pessoa(this.nome, this.idade, this.tipo);
}

void maiorDeIdade(List<Pessoa> pessoas) {
  for (var pessoa in pessoas) {
    if (pessoa.tipo == Tipo.maior) {
      print(pessoa.nome);
    }
  }
}
void main(List<String> arguments) {
  List<Pessoa> pessoas = [
    Pessoa('Daniel', 19, Tipo.menor),
    Pessoa('Liedson', 17, Tipo.maior),
    Pessoa('Niguel', 18, Tipo.maior),
    Pessoa('Eduardo', 15, Tipo.menor),
  ];

  maiorDeIdade(pessoas);
}