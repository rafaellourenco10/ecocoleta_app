import 'package:flutter_test/flutter_test.dart';
import 'package:ecocoleta_app/core/validators.dart';

void main() {
  test('campo obrigatório vazio é rejeitado', () {
    expect(Validators.obrigatorio('   ', campo: 'Nome'), 'Nome é obrigatório');
    expect(Validators.obrigatorio('Rafael'), isNull);
  });

  test('e-mail inválido é rejeitado', () {
    expect(Validators.email('rafael@'), 'Digite um e-mail válido');
    expect(Validators.email(''), 'E-mail é obrigatório');
    expect(Validators.email('rafael@email.com'), isNull);
  });

  test('senha curta é rejeitada', () {
    expect(Validators.senha('123'), 'A senha deve ter ao menos 6 caracteres');
    expect(Validators.senha('123456'), isNull);
  });

  test('telefone sem DDD é rejeitado', () {
    expect(Validators.telefone('9999-9999'), 'Telefone inválido (informe DDD + número)');
    expect(Validators.telefone('(11) 99999-9999'), isNull);
  });

  test('CPF e CNPJ com dígito verificador errado são rejeitados', () {
    expect(Validators.cpfCnpj('111.111.111-11'), 'CPF inválido');
    expect(Validators.cpfCnpj('529.982.247-24'), 'CPF inválido');
    expect(Validators.cpfCnpj('529.982.247-25'), isNull);
    expect(Validators.cpfCnpj('11.222.333/0001-80'), 'CNPJ inválido');
    expect(Validators.cpfCnpj('11.222.333/0001-81'), isNull);
    expect(Validators.cpfCnpj('123'), 'CPF deve ter 11 dígitos ou CNPJ 14 dígitos');
  });
}
