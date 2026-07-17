class Validators {
  static String? obrigatorio(String? valor, {String campo = 'Este campo'}) {
    if (valor == null || valor.trim().isEmpty) {
      return '$campo é obrigatório';
    }
    return null;
  }

  static String? email(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'E-mail é obrigatório';
    }
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(valor.trim())) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  static String? senha(String? valor, {int minimo = 6}) {
    if (valor == null || valor.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (valor.length < minimo) {
      return 'A senha deve ter ao menos $minimo caracteres';
    }
    return null;
  }

  static String? telefone(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Telefone é obrigatório';
    }
    final digitos = valor.replaceAll(RegExp(r'\D'), '');
    if (digitos.length < 10 || digitos.length > 11) {
      return 'Telefone inválido (informe DDD + número)';
    }
    return null;
  }

  static String? cpfCnpj(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'CPF ou CNPJ é obrigatório';
    }
    final digitos = valor.replaceAll(RegExp(r'\D'), '');
    if (digitos.length == 11) {
      return _validarCpf(digitos) ? null : 'CPF inválido';
    }
    if (digitos.length == 14) {
      return _validarCnpj(digitos) ? null : 'CNPJ inválido';
    }
    return 'CPF deve ter 11 dígitos ou CNPJ 14 dígitos';
  }

  static bool _validarCpf(String cpf) {
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    final numeros = cpf.split('').map(int.parse).toList();

    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += numeros[i] * (10 - i);
    }
    int resto = (soma * 10) % 11;
    if (resto == 10) resto = 0;
    if (resto != numeros[9]) return false;

    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += numeros[i] * (11 - i);
    }
    resto = (soma * 10) % 11;
    if (resto == 10) resto = 0;
    if (resto != numeros[10]) return false;

    return true;
  }

  static bool _validarCnpj(String cnpj) {
    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;

    final numeros = cnpj.split('').map(int.parse).toList();

    const pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int soma = 0;
    for (int i = 0; i < 12; i++) {
      soma += numeros[i] * pesos1[i];
    }
    int resto = soma % 11;
    int digito1 = resto < 2 ? 0 : 11 - resto;
    if (digito1 != numeros[12]) return false;

    const pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    soma = 0;
    for (int i = 0; i < 13; i++) {
      soma += numeros[i] * pesos2[i];
    }
    resto = soma % 11;
    int digito2 = resto < 2 ? 0 : 11 - resto;
    if (digito2 != numeros[13]) return false;

    return true;
  }
}
