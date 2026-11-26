import 'package:flutter/material.dart';
import 'cadastro_screen.dart';
import '../services/usuario_service.dart';
import 'catalogo_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _mostrarSenha = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    if (!_formKey.currentState!.validate()) return;

    final usuario = UsuarioService.autenticar(
      _usuarioController.text,
      _senhaController.text,
    );

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha incorretos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CatalogoScreen(nomeUsuario: usuario.nome),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo_login.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 280,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.60),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo_gatinho.png',
                      width: 220,
                      height: 65,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'LOGIN',
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextFormField(
                      controller: _usuarioController,
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: _campoDecoracao('Usuário'),
                      validator: (valor) {
                        if (valor == null || valor.trim().isEmpty) {
                          return 'Digite seu usuário';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _senhaController,
                      obscureText: !_mostrarSenha,
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: _campoDecoracao('Senha').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarSenha
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarSenha = !_mostrarSenha;
                            });
                          },
                        ),
                      ),
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Digite sua senha';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 5),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CadastroScreen(),
                          ),
                        );
                      },

                      child: Text(
                        'Cadastre-se',
                        style: GoogleFonts.alice(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    ElevatedButton(
                      onPressed: _entrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5C5E5),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.alice(
                          color: Colors.white,
                          fontSize: 16,
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
    );
  }

  InputDecoration _campoDecoracao(String texto) {
    return InputDecoration(
      labelText: texto,
      labelStyle: GoogleFonts.alice(color: Colors.white, fontSize: 16),
      filled: true,
      fillColor: const Color(0xFF350052),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      errorStyle: GoogleFonts.alice(
        color: const Color(0xFFFF9B9B),
        fontSize: 12,
      ),
    );
  }
}
