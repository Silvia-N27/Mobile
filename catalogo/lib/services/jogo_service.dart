//exercicio 5 crud de jogos

import 'dart:typed_data';
import '../models/jogo.dart';

class JogoService {
  static final List<Jogo> _jogos = [];

  static int _proximoId = 1;

  // CREATE - Cadastrar um jogo
  static void cadastrar({
    required String nome,
    required String genero,
    required String plataforma,
    required String desenvolvedora,
    required DateTime dataLancamento,
    required Uint8List capa,
    required String descricao,
  }) {
    final jogo = Jogo(
      id: _proximoId++,
      nome: nome,
      genero: genero,
      plataforma: plataforma,
      desenvolvedora: desenvolvedora,
      dataLancamento: dataLancamento,
      capa: capa,
      descricao: descricao,
    );

    _jogos.add(jogo);
  }

  // READ - Listar os jogos
  static List<Jogo> listar() {
    return List.unmodifiable(_jogos);
  }

  // UPDATE - Editar um jogo
  static void atualizar(Jogo jogoAtualizado) {
    final indice = _jogos.indexWhere(
      (jogo) => jogo.id == jogoAtualizado.id,
    );

    if (indice != -1) {
      _jogos[indice] = jogoAtualizado;
    }
  }

  // DELETE - Excluir um jogo
  static void excluir(int id) {
    _jogos.removeWhere(
      (jogo) => jogo.id == id,
    );
  }
}
