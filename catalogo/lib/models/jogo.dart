//exercicio 5 entidade jogo

import 'dart:typed_data';

class Jogo {
  final int id;
  String nome;
  String genero;
  String plataforma;
  String desenvolvedora;
  DateTime dataLancamento;
  Uint8List capa;
  String descricao;

  Jogo({
    required this.id,
    required this.nome,
    required this.genero,
    required this.plataforma,
    required this.desenvolvedora,
    required this.dataLancamento,
    required this.capa,
    required this.descricao,
  });
}
