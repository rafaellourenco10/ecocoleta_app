import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Agora usamos StatefulWidget porque a tela muda de estado (carregando, digitando, etc)
class TelaFormulario extends StatefulWidget {
  const TelaFormulario({super.key});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  // Controladores para capturar o que o usuário digitar
  final _materialController = TextEditingController();
  final _enderecoController = TextEditingController();
  bool _estaCarregando = false; // Controla a animação do botão

  // Função que envia os dados para o XAMPP
  Future<void> enviarDados() async {
    setState(() {
      _estaCarregando = true; // Liga a bolinha girando
    });

    // O ENDEREÇO DA SUA MÁQUINA COM O SEU IP!
    var url = Uri.parse('http://192.168.237.64/ecocoleta/cadastrar_coleta.php');

    try {
      var resposta = await http.post(
        url,
        body: {
          'material': _materialController.text,
          'endereco': _enderecoController.text,
        },
      );

      if (resposta.statusCode == 200) {
        // Se deu certo, mostra um aviso verde e limpa a tela
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Coleta solicitada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        _materialController.clear();
        _enderecoController.clear();
      } else {
        // Se o servidor reclamou
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro no servidor: ${resposta.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Se o celular não achou o computador (ex: fora do wifi)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Verifique o Wi-Fi e o XAMPP.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _estaCarregando = false; // Desliga a bolinha girando
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Coleta', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Deixa a setinha de voltar branca
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'O que você quer descartar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _materialController,
              decoration: const InputDecoration(
                hintText: 'Ex: Eletrônicos, Papelão, Vidro...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Onde devemos buscar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(
                hintText: 'Ex: Rua das Flores, 123',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),

            // Botão que muda de texto para bolinha de carregamento
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _estaCarregando ? null : enviarDados,
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
                      'Enviar Solicitação',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
