import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';
import 'api_exception.dart';

class ColetaService {
  static Future<void> cadastrar({
    required String usuarioId,
    required String tipoResiduo,
    required String volume,
    required String acondicionamento,
    required String descricaoItem,
    required String endereco,
    required String urlFoto,
  }) async {
    http.Response resposta;
    try {
      resposta = await http.post(
        Uri.parse(ApiConstants.cadastrarColeta),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'usuario_id': usuarioId,
          'tipo_residuo': tipoResiduo,
          'volume': volume,
          'acondicionamento': acondicionamento,
          'descricao_item': descricaoItem,
          'endereco': endereco,
          'url_foto': urlFoto,
        }),
      );
    } catch (_) {
      throw const ApiException('Erro de conexão. Verifique sua internet e tente novamente.');
    }

    if (resposta.statusCode != 201) {
      throw ApiException(mensagemErroDe(resposta));
    }
  }

  static Future<List<dynamic>> listarPorUsuario(String usuarioId) async {
    http.Response resposta;
    try {
      resposta = await http.get(Uri.parse(ApiConstants.listarColetas(usuarioId)));
    } catch (_) {
      throw const ApiException('Erro de conexão ao buscar coletas.');
    }

    if (resposta.statusCode != 200) {
      throw ApiException(mensagemErroDe(resposta));
    }
    return json.decode(resposta.body) as List<dynamic>;
  }

  static Future<void> editar(
    String id, {
    required String tipoResiduo,
    required String descricaoItem,
    required String endereco,
  }) async {
    http.Response resposta;
    try {
      resposta = await http.put(
        Uri.parse(ApiConstants.editarColeta(id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tipo_residuo': tipoResiduo,
          'descricao_item': descricaoItem,
          'endereco': endereco,
        }),
      );
    } catch (_) {
      throw const ApiException('Erro de conexão ao editar a coleta.');
    }

    if (resposta.statusCode != 200) {
      throw ApiException(mensagemErroDe(resposta));
    }
  }

  static Future<void> deletar(String id) async {
    http.Response resposta;
    try {
      resposta = await http.delete(Uri.parse(ApiConstants.deletarColeta(id)));
    } catch (_) {
      throw const ApiException('Erro de conexão ao excluir a coleta.');
    }

    if (resposta.statusCode != 200 && resposta.statusCode != 204) {
      throw ApiException(mensagemErroDe(resposta));
    }
  }
}
