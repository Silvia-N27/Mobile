//exercicio 5 cadastro e edição de jogos e validação dos campos

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../models/jogo.dart';
import '../services/jogo_service.dart';

class JogoFormScreen extends StatefulWidget {
  final Jogo? jogo;

  const JogoFormScreen({super.key, this.jogo});

  @override
  State<JogoFormScreen> createState() => _JogoFormScreenState();
}

class _JogoFormScreenState extends State<JogoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _desenvolvedoraController = TextEditingController();
  final _descricaoController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  String? _genero;
  String? _plataforma;
  DateTime? _dataLancamento;

  Uint8List? _capaBytes;
  String? _nomeArquivo;

  bool _selecionandoImagem = false;

  static const Color _roxo = Color(0xFF350052);
  static const Color _lilas = Color(0xFFD5C5E5);

  final List<String> _generos = [
    'Ação',
    'Aventura',
    'RPG',
    'MMORPG',
    'Estratégia',
    'Simulação',
    'Terror',
    'Ritmo',
    'Esportes',
    'Corrida',
    'Outro',
  ];

  final List<String> _plataformas = [
    'PC',
    'PlayStation',
    'Xbox',
    'Nintendo Switch',
    'Android',
    'iOS',
    'Multiplataforma',
  ];

  @override
  void initState() {
    super.initState();

    final jogo = widget.jogo;

    if (jogo != null) {
      _nomeController.text = jogo.nome;
      _desenvolvedoraController.text = jogo.desenvolvedora;
      _descricaoController.text = jogo.descricao;

      _genero = jogo.genero;
      _plataforma = jogo.plataforma;
      _dataLancamento = jogo.dataLancamento;
      _capaBytes = jogo.capa;
      _nomeArquivo = 'Capa atual selecionada';
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _desenvolvedoraController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarImagem() async {
    if (_selecionandoImagem) return;

    setState(() {
      _selecionandoImagem = true;
    });

    try {
      final XFile? imagem = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (imagem == null) return;

      final bytes = await imagem.readAsBytes();

      if (!mounted) return;

      setState(() {
        _capaBytes = bytes;
        _nomeArquivo = imagem.name;
      });
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $erro')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _selecionandoImagem = false;
        });
      }
    }
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataLancamento ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (data != null) {
      setState(() {
        _dataLancamento = data;
      });
    }
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem), backgroundColor: _roxo));
  }

  void _salvarJogo() {
    if (!_formKey.currentState!.validate()) return;

    if (_dataLancamento == null) {
      _mostrarMensagem('Selecione a data de lançamento');
      return;
    }

    if (_capaBytes == null) {
      _mostrarMensagem('Selecione uma capa para o jogo');
      return;
    }

    if (widget.jogo == null) {
      // CREATE - CADASTRAR
      JogoService.cadastrar(
        nome: _nomeController.text.trim(),
        genero: _genero!,
        plataforma: _plataforma!,
        desenvolvedora: _desenvolvedoraController.text.trim(),
        dataLancamento: _dataLancamento!,
        capa: _capaBytes!,
        descricao: _descricaoController.text.trim(),
      );
    } else {
      // UPDATE - EDITAR
      final jogoAtualizado = Jogo(
        id: widget.jogo!.id,
        nome: _nomeController.text.trim(),
        genero: _genero!,
        plataforma: _plataforma!,
        desenvolvedora: _desenvolvedoraController.text.trim(),
        dataLancamento: _dataLancamento!,
        capa: _capaBytes!,
        descricao: _descricaoController.text.trim(),
      );

      JogoService.atualizar(jogoAtualizado);
    }

    Navigator.pop(context, true);
  }

  String? _validarObrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  InputDecoration _decoracao(String texto) {
    return InputDecoration(
      labelText: texto,
      labelStyle: GoogleFonts.alice(color: Colors.white, fontSize: 15),
      floatingLabelStyle: GoogleFonts.alice(color: Colors.white, fontSize: 14),
      filled: true,
      fillColor: _roxo,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide.none,
      ),
      errorStyle: GoogleFonts.alice(
        color: const Color(0xFFFF9B9B),
        fontSize: 12,
      ),
    );
  }

  Widget _espaco() {
    return const SizedBox(height: 16);
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.jogo != null;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 55,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          editando ? 'Atualizar informações' : 'Cadastro de jogos',
          style: GoogleFonts.alice(color: Colors.white, fontSize: 18),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
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
        ),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Center(
                child: SizedBox(
                  width: 245,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // NOME
                        TextFormField(
                          controller: _nomeController,
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          decoration: _decoracao('Nome'),
                          validator: _validarObrigatorio,
                        ),

                        _espaco(),

                        // GÊNERO
                        DropdownButtonFormField<String>(
                          initialValue: _genero,
                          isExpanded: true,
                          dropdownColor: _roxo,
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: _lilas,
                          ),
                          decoration: _decoracao('Gênero'),
                          items: _generos.map((genero) {
                            return DropdownMenuItem<String>(
                              value: genero,
                              child: Text(
                                genero,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (valor) {
                            setState(() {
                              _genero = valor;
                            });
                          },
                          validator: (valor) {
                            if (valor == null) {
                              return 'Selecione um gênero';
                            }
                            return null;
                          },
                        ),

                        _espaco(),

                        // PLATAFORMA
                        DropdownButtonFormField<String>(
                          initialValue: _plataforma,
                          isExpanded: true,
                          dropdownColor: _roxo,
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: _lilas,
                          ),
                          decoration: _decoracao('Plataforma'),
                          items: _plataformas.map((plataforma) {
                            return DropdownMenuItem<String>(
                              value: plataforma,
                              child: Text(
                                plataforma,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (valor) {
                            setState(() {
                              _plataforma = valor;
                            });
                          },
                          validator: (valor) {
                            if (valor == null) {
                              return 'Selecione uma plataforma';
                            }
                            return null;
                          },
                        ),

                        _espaco(),

                        // DESENVOLVEDORA
                        TextFormField(
                          controller: _desenvolvedoraController,
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          decoration: _decoracao('Desenvolvedora'),
                          validator: _validarObrigatorio,
                        ),

                        _espaco(),

                        // DATA DE LANÇAMENTO
                        InkWell(
                          onTap: _selecionarData,
                          child: InputDecorator(
                            decoration: _decoracao('Data de lançamento'),
                            child: Text(
                              _dataLancamento == null
                                  ? 'Selecionar data'
                                  : '${_dataLancamento!.day.toString().padLeft(2, '0')}/'
                                        '${_dataLancamento!.month.toString().padLeft(2, '0')}/'
                                        '${_dataLancamento!.year}',
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),

                        _espaco(),

                        // CAPA DO JOGO
                        InkWell(
                          onTap: _selecionandoImagem ? null : _selecionarImagem,
                          borderRadius: BorderRadius.circular(3),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: _roxo,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selecionandoImagem
                                        ? 'Selecionando...'
                                        : _nomeArquivo ?? 'Capa do jogo',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.alice(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.image_outlined,
                                  color: _lilas,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        _espaco(),

                        // DESCRIÇÃO
                        TextFormField(
                          controller: _descricaoController,
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          decoration: _decoracao('Descrição'),
                          maxLines: 3,
                          validator: _validarObrigatorio,
                        ),

                        const SizedBox(height: 45),

                        // BOTÃO CONFIRMAR
                        ElevatedButton(
                          onPressed: _selecionandoImagem ? null : _salvarJogo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _lilas,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(120, 38),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Confirmar',
                                style: GoogleFonts.alice(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.check,
                                color: Color(0xFF72FFB2),
                                size: 19,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
