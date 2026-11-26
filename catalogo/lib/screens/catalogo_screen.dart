import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/jogo.dart';
import '../services/jogo_service.dart';
import 'jogo_form_screen.dart';
import 'login_screen.dart';

class CatalogoScreen extends StatefulWidget {
  final String nomeUsuario;

  const CatalogoScreen({
    super.key,
    required this.nomeUsuario,
  });

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  bool _modoEdicao = false;
  bool _modoExclusao = false;
  int? _jogoExpandido;

  final Set<int> _selecionados = {};

  static const Color _lilas = Color(0xFFAD8BC7);
  static const Color _vermelho = Color(0xFFFF4F62);

  static const BoxDecoration _fundo = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF3D1457),
        Colors.black,
        Colors.black,
        Color(0xFF3D1457),
      ],
      stops: [0.0, 0.13, 0.87, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: const Color(0xFF45215F),
      ),
    );
  }

  // CREATE - Cadastrar
  Future<void> _adicionarJogo() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const JogoFormScreen(),
      ),
    );

    if (!mounted) return;

    if (resultado == true) {
      setState(() {});
      _mostrarMensagem('Jogo cadastrado com sucesso!');
    }
  }

  // UPDATE - Editar
  Future<void> _editarJogo(Jogo jogo) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => JogoFormScreen(jogo: jogo),
      ),
    );

    if (!mounted) return;

    if (resultado == true) {
      setState(() {
        _modoEdicao = false;
      });
      _mostrarMensagem('Jogo atualizado com sucesso!');
    }
  }

  void _ativarEdicao() {
    setState(() {
      _modoEdicao = !_modoEdicao;
      _modoExclusao = false;
      _selecionados.clear();
    });
  }

  void _ativarExclusao() {
    setState(() {
      _modoExclusao = !_modoExclusao;
      _modoEdicao = false;
      _selecionados.clear();
    });
  }

  void _cancelarSelecao() {
    setState(() {
      _modoEdicao = false;
      _modoExclusao = false;
      _selecionados.clear();
    });
  }

  void _alternarSelecao(int id) {
    setState(() {
      if (_selecionados.contains(id)) {
        _selecionados.remove(id);
      } else {
        _selecionados.add(id);
      }
    });
  }

  // DELETE - Excluir com confirmação
  Future<void> _confirmarExclusao() async {
    if (_selecionados.isEmpty) {
      _mostrarMensagem('Selecione um jogo para excluir.');
      return;
    }

    final quantidade = _selecionados.length;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFCBBBD9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(
            'TEM CERTEZA?',
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(color: Colors.white, fontSize: 22),
          ),
          content: Text(
            quantidade == 1
                ? 'Após confirmar, o jogo será deletado '
                    'de forma permanente e não será possível recuperá-lo.'
                : 'Após confirmar, os $quantidade jogos '
                    'serão deletados de forma permanente e não será possível recuperá-los.',
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(
              color: Colors.white,
              fontSize: 17,
              height: 1.3,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            IconButton(
              tooltip: 'Cancelar',
              onPressed: () => Navigator.pop(dialogContext, false),
              icon: const Icon(
                Icons.close,
                color: Color(0xFFFF5964),
                size: 42,
              ),
            ),
            IconButton(
              tooltip: 'Confirmar exclusão',
              onPressed: () => Navigator.pop(dialogContext, true),
              icon: const Icon(
                Icons.check,
                color: Color(0xFF72FFB2),
                size: 42,
              ),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmar != true) return;

    for (final id in _selecionados) {
      JogoService.excluir(id);
    }

    setState(() {
      _selecionados.clear();
      _modoExclusao = false;
      _jogoExpandido = null;
    });
    _mostrarMensagem('Jogo(s) excluído(s) com sucesso!');
  }

  Widget _botaoAcao({
    required IconData icone,
    required Color cor,
    required VoidCallback acao,
    required String descricao,
  }) {
    return IconButton(
      tooltip: descricao,
      onPressed: acao,
      icon: Icon(icone, color: Colors.white, size: 23),
      style: IconButton.styleFrom(
        backgroundColor: cor,
        minimumSize: const Size(43, 43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // READ - Lista com descrição expansível
  Widget _construirJogo(Jogo jogo) {
    final selecionado = _selecionados.contains(jogo.id);
    final expandido = _jogoExpandido == jogo.id;

    return InkWell(
      onTap: () {
        if (_modoEdicao) {
          _editarJogo(jogo);
        } else if (_modoExclusao) {
          _alternarSelecao(jogo.id);
        } else {
          setState(() {
            _jogoExpandido = expandido ? null : jogo.id;
          });
        }
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: selecionado
                ? const Color(0xFF350052).withValues(alpha: 0.65)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.memory(
                  jogo.capa,
                  width: 72,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 72,
                      height: 96,
                      color: const Color(0xFF350052),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jogo.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${jogo.genero} - ${jogo.plataforma}',
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      jogo.desenvolvedora,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      'Lançamento: '
                      '${jogo.dataLancamento.day.toString().padLeft(2, '0')}/'
                      '${jogo.dataLancamento.month.toString().padLeft(2, '0')}/'
                      '${jogo.dataLancamento.year}',
                      style: GoogleFonts.alice(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      jogo.descricao,
                      maxLines: expandido ? null : 3,
                      overflow: expandido
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      softWrap: true,
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (_modoExclusao)
                Checkbox(
                  value: selecionado,
                  activeColor: _lilas,
                  side: const BorderSide(color: Colors.white),
                  onChanged: (valor) => _alternarSelecao(jogo.id),
                )
              else if (_modoEdicao)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.edit, size: 19, color: _lilas),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _sair() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jogos = JogoService.listar();

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        backgroundColor: const Color(0xFF16051F),
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text(
                  widget.nomeUsuario,
                  style: GoogleFonts.alice(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Sair',
                  style: GoogleFonts.alice(color: Colors.white),
                ),
                onTap: _sair,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 55,
        leading: _modoEdicao || _modoExclusao
            ? IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: _cancelarSelecao,
              )
            : null,
        title: Text(
          _modoExclusao
              ? 'Selecione os que deseja deletar'
              : _modoEdicao
                  ? 'Selecione um jogo para editar'
                  : 'Catálogo de Jogos',
          style: GoogleFonts.alice(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: _fundo,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: jogos.isEmpty
                ? Center(
                    child: Text(
                      'Nenhum jogo cadastrado ainda.',
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    itemCount: jogos.length,
                    itemBuilder: (context, index) {
                      return _construirJogo(jogos[index]);
                    },
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: _fundo,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        child: SafeArea(
          top: false,
          child: _modoExclusao
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _botaoAcao(
                      icone: Icons.delete_outline,
                      cor: _vermelho,
                      descricao: 'Confirmar exclusão',
                      acao: _confirmarExclusao,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _botaoAcao(
                      icone: Icons.edit,
                      cor: _lilas,
                      descricao: 'Editar jogos',
                      acao: _ativarEdicao,
                    ),
                    _botaoAcao(
                      icone: Icons.delete_outline,
                      cor: _vermelho,
                      descricao: 'Excluir jogos',
                      acao: _ativarExclusao,
                    ),
                    _botaoAcao(
                      icone: Icons.add,
                      cor: _lilas,
                      descricao: 'Adicionar jogo',
                      acao: _adicionarJogo,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
