class ApiConstants {
  // Aponta para a API na nuvem (Render) por padrão. Para apontar para uma API
  // local, rode com: flutter run --dart-define=API_BASE_URL=http://<seu-ip-local>:3000/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://ecocoleta-api-imd4.onrender.com/api',
  );

  // Rotas de Usuário
  static const String registrarUsuario = '$baseUrl/usuarios/registrar';
  static const String loginUsuario = '$baseUrl/usuarios/login';
  static String obterPerfil(String id) => '$baseUrl/usuarios/$id';
  static String atualizarPerfil(String id) => '$baseUrl/usuarios/$id';

  // Rotas de Coleta
  static const String cadastrarColeta = '$baseUrl/coletas';
  static String listarColetas(String usuarioId) => '$baseUrl/coletas/usuario/$usuarioId';
  static String editarColeta(String id) => '$baseUrl/coletas/$id';
  static String deletarColeta(String id) => '$baseUrl/coletas/$id';
}
