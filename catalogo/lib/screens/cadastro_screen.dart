//P2 cadastro de usuários

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/usuario_service.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _mostrarSenha = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (!_formKey.currentState!.validate()) return;

    final usuario = Usuario(
      nome: _usuarioController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      senha: _senhaController.text,
    );

    final cadastrado = UsuarioService.cadastrar(usuario);

    if (!cadastrado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou e-mail já cadastrado!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context, true);
  }

  InputDecoration _decoracao(String nome) {
    return InputDecoration(
      labelText: nome,
      labelStyle: GoogleFonts.alice(color: Colors.white, fontSize: 15),
      floatingLabelStyle: GoogleFonts.alice(color: Colors.white, fontSize: 15),
      filled: true,
      fillColor: const Color(0xFF350052),
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
    return const SizedBox(height: 14);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  tooltip: 'Voltar',
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Center(
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.60),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Cadastro',
                              style: GoogleFonts.alice(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 22),

                            TextFormField(
                              controller: _usuarioController,
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: _decoracao('Usuário'),
                              validator: (valor) {
                                if (valor == null || valor.trim().length < 3) {
                                  return 'Mínimo de 3 caracteres';
                                }
                                return null;
                              },
                            ),

                            _espaco(),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: _decoracao('E-mail'),
                              validator: (valor) {
                                if (valor == null ||
                                    !RegExp(
                                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                    ).hasMatch(valor.trim())) {
                                  return 'Digite um e-mail válido';
                                }
                                return null;
                              },
                            ),

                            _espaco(),

                            TextFormField(
                              controller: _telefoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: _decoracao('Telefone'),
                              validator: (valor) {
                                final numeros = (valor ?? '').replaceAll(
                                  RegExp(r'\D'),
                                  '',
                                );

                                if (numeros.length != 10 &&
                                    numeros.length != 11) {
                                  return 'Telefone deve ter 10 ou 11 números';
                                }
                                return null;
                              },
                            ),

                            _espaco(),

                            TextFormField(
                              controller: _senhaController,
                              obscureText: !_mostrarSenha,
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: _decoracao('Senha').copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _mostrarSenha
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white70,
                                    size: 19,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _mostrarSenha = !_mostrarSenha;
                                    });
                                  },
                                ),
                              ),
                              validator: (valor) {
                                if (valor == null || valor.length < 6) {
                                  return 'Senha deve ter no mínimo 6 caracteres';
                                }
                                return null;
                              },
                            ),

                            _espaco(),

                            TextFormField(
                              controller: _confirmarSenhaController,
                              obscureText: !_mostrarSenha,
                              style: GoogleFonts.alice(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: _decoracao('Confirmar senha'),
                              validator: (valor) {
                                if (valor == null || valor.isEmpty) {
                                  return 'Confirme sua senha';
                                }

                                if (valor != _senhaController.text) {
                                  return 'As senhas não coincidem';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 22),

                            ElevatedButton(
                              onPressed: _cadastrar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD5C5E5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 9,
                                ),
                                minimumSize: const Size(100, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Confirmar',
                                style: GoogleFonts.alice(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
