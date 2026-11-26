//P2 gerenciamento e autenticação de usuários

class Usuario {
  final String nome;
  final String email;
  final String telefone;
  final String senha;

  Usuario({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha,
  });
}

class UsuarioService {
  static final List<Usuario> _usuarios = [];

  static bool cadastrar(Usuario usuario) {
    final jaExiste = _usuarios.any(
      (u) =>
          u.nome.toLowerCase() == usuario.nome.toLowerCase() ||
          u.email.toLowerCase() == usuario.email.toLowerCase(),
    );

    if (jaExiste) return false;

    _usuarios.add(usuario);
    return true;
  }

  static Usuario? autenticar(String nome, String senha) {
    for (final usuario in _usuarios) {
      if (usuario.nome.toLowerCase() == nome.trim().toLowerCase() &&
          usuario.senha == senha) {
        return usuario;
      }
    }

    return null;
  }
}
