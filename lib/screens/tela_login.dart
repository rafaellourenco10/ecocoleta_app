import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_inicial.dart';
import 'tela_cadastro.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Controladores para capturar e-mail e senha
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Variável para mostrar o ícone de carregamento no botão
  bool _estaCarregando = false;

  Future<void> realizarLogin() async {
    // Inicia a animação de carregamento
    setState(() {
      _estaCarregando = true;
    });

    // URL da sua API no XAMPP (mantenha o seu IP atualizado)
    var url = Uri.parse('http://192.168.237.64/ecocoleta/login.php');

    try {
      var resposta = await http.post(
        url,
        body: {'email': _emailController.text, 'senha': _senhaController.text},
      );

      // Decodifica a resposta JSON que vem do PHP
      var dados = json.decode(resposta.body);

      if (dados['status'] == 'sucesso') {
        // Login realizado com sucesso!
        if (!mounted) return;

        // Extrai o nome do usuário do JSON para passar para a próxima tela
        String nomeParaEnviar = dados['usuario']['nome'];

        // Navega para a Tela Inicial passando o nome
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TelaInicial(nomeUsuario: nomeParaEnviar),
          ),
        );
      } else {
        // Mostra o erro retornado pelo PHP (ex: "Senha incorreta")
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(dados['mensagem']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Caso o servidor esteja desligado ou o IP mude
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Verifique o servidor XAMPP.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Para a animação de carregamento, dando erro ou sucesso
      if (mounted) {
        setState(() {
          _estaCarregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.recycling, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                'EcoColeta',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 40),

              // Campo de E-mail
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

              // Campo de Senha
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              // Botão Esqueci minha senha
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Funcionalidade em breve!')),
                    );
                  },
                  child: const Text(
                    'Esqueci minha senha?',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Botão Entrar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _estaCarregando ? null : realizarLogin,
                child: _estaCarregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),

              const SizedBox(height: 20),

              // Botão para Ir para o Cadastro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaCadastro(),
                    ),
                  );
                },
                child: const Text(
                  'Ainda não tem uma conta? Cadastre-se',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
