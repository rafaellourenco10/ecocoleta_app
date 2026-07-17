import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'api_exception.dart';

class UsuarioService {
  static Future<void> registrar({
    required String nome,
    required String cpfCnpj,
    required String endereco,
    required String telefone,
    required String email,
    required String senha,
  }) async {
    http.Response resposta;
    try {
      resposta = await http.post(
        Uri.parse(ApiConstants.registrarUsuario),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nome': nome,
          'cpf_cnpj': cpfCnpj,
          'endereco': endereco,
          'telefone': telefone,
          'email': email,
          'senha': senha,
        }),
      );
    } catch (_) {
      throw const ApiException('Erro de conexão. Verifique se a API está rodando.');
    }

    if (resposta.statusCode != 201) {
      throw ApiException(mensagemErroDe(resposta));
    }
  }

  static Future<Map<String, dynamic>> obterPerfil(String usuarioId) async {
    http.Response resposta;
    try {
      resposta = await http.get(Uri.parse(ApiConstants.obterPerfil(usuarioId)));
    } catch (_) {
      throw const ApiException('Erro de conexão ao carregar o perfil.');
    }

    if (resposta.statusCode != 200) {
      throw ApiException(mensagemErroDe(resposta));
    }
    return json.decode(resposta.body) as Map<String, dynamic>;
  }

  static Future<void> atualizarPerfil(
    String usuarioId, {
    required String nome,
    required String email,
    required String telefone,
    required String endereco,
  }) async {
    http.Response resposta;
    try {
      resposta = await http.put(
        Uri.parse(ApiConstants.atualizarPerfil(usuarioId)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'telefone': telefone,
          'endereco': endereco,
        }),
      );
    } catch (_) {
      throw const ApiException('Erro de conexão ao atualizar o perfil.');
    }

    if (resposta.statusCode != 200) {
      throw ApiException(mensagemErroDe(resposta));
    }
  }
}
