import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Invertextoservice {
  final String _token = "25405|ke7JOpDwRM0hlWKgDybnErM7Lk3lFKym";

  Future<Map<String, dynamic>> convertePorExtenso(String? valor) async {
    try {
      final url = Uri.parse(
        "https://api.invertexto.com/v1/number-to-words?token=$_token&number=$valor&language=pt&currency=BRL",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode} : ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCEP(String? valor) async {
    try {
      final url = Uri.parse(
        "https://api.invertexto.com/v1/cep/$valor?token=$_token",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Erro ${response.statusCode} : ${response.body}');
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> validarCPFeCNPJ(
    String? valor,
    String? tipo,
  ) async {
    try {
      final url = Uri.parse(
        "https://api.invertexto.com/v1/validator?token=$_token&value=$valor&type=$tipo",
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        final body = json.decode(response.body);
        throw Exception(body["message"] ?? "Erro ao validar CPF/CNPJ");
      }
    } on SocketException {
      throw Exception('Erro de conexão com a internet');
    } catch (e) {
      rethrow;
    }
  }
}
