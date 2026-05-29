class ApiConstants {
  // A API agora está hospedada na nuvem (Render). O app funcionará no 4G e em qualquer Wi-Fi!
  static const String baseUrl = 'https://ecocoleta-api-imd4.onrender.com/api';

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
