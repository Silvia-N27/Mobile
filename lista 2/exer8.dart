void main(List<String> arguments) {
  Map<String, double> precosFrutas = {
    'Manga': 3.50,'Laranja': 1.00,'Melancia': 5.00,'Banana': 2.50,'Maçã': 2.00
  };

  precosFrutas.forEach((fruta, preco) {print('$fruta: $preco');});
}
