import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

String mensagemErroDe(http.Response resposta) {
  try {
    final dados = json.decode(resposta.body);
    return dados['error'] ?? 'Erro no servidor: ${resposta.statusCode}';
  } catch (_) {
    return 'Erro no servidor: ${resposta.statusCode}';
  }
}
