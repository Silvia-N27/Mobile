import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PokemonService {
  Future<Map<String, dynamic>> buscarPokemon(String? nome) async {
    try {
      final url = Uri.parse(
        "https://pokeapi.co/api/v2/pokemon/${nome?.toLowerCase()}",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode} : ${response.body}');
      }
    } on SocketException {
      throw Exception("Erro de conexão com a internet");
    } catch (e) {
      rethrow;
    }
  }
}
