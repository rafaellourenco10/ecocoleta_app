import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Controladores para capturar os dados digitados
  final _nomeController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _estaCarregando = false; // Variável para controlar a animação do botão

  Future<void> enviarCadastro() async {
    setState(() {
      _estaCarregando = true;
    });

    // O IP da sua máquina
    var url = Uri.parse(
      'http://192.168.237.64/ecocoleta/cadastrar_usuario.php',
    );

    try {
      var resposta = await http.post(
        url,
        body: {
          'nome': _nomeController.text,
          'cpf_cnpj': _cpfCnpjController.text,
          'endereco': _enderecoController.text,
          'telefone': _telefoneController.text,
          'email': _emailController.text,
          'senha': _senhaController.text,
        },
      );

      if (resposta.statusCode == 200) {
        // Mostra aviso de sucesso e volta para a tela de Login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conta criada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro no servidor: ${resposta.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Verifique o Wi-Fi e o XAMPP.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _estaCarregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Complete seus dados',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),

            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome Completo ou Razão Social',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _cpfCnpjController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'CPF ou CNPJ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço Completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone / WhatsApp',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _estaCarregando ? null : enviarCadastro,
              child: _estaCarregando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Finalizar Cadastro',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
