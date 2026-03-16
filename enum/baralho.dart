enum Naipe {
  copas, ouro, espada, paus
}

enum Valor {
  as,
  dois,
  tres,
  quatro,
  cinco,
  seis,
  sete,
  oito,
  nove,
  dez,
  valete,
  dama,
  rei,
}

class Carta {
  Naipe naipe;
  Valor valor;

  Carta(this.naipe, this.valor);

  @override
  String toString() {
    return '${valor.name.toUpperCase()} DE ${naipe.name.toUpperCase()}';
  }
}

class Baralho {
  List<Carta> cartas = [];

  Baralho() {
    for (var naipe in Naipe.values) {
      for (var valor in Valor.values) {
        cartas.add(Carta(naipe, valor));
      }
    }
  }

  void embalharar() {
    cartas.shuffle();
  }

  Carta comprar() {
    return cartas.removeLast();
  }

  int cartasRestantes() {
    return cartas.length;
  }
}

void main(List<String> arguments) {
  Baralho baralho = Baralho();

  baralho.embalharar();

  for (int i = 0; i < 5; i++) {
    print(baralho.comprar());
  }

  print('Cartas restante: ${baralho.cartasRestantes()}');
}
