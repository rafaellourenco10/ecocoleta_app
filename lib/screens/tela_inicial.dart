import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'tela_formulario.dart';

class TelaInicial extends StatelessWidget {
  // Variável que armazena o nome recebido da tela de login
  final String nomeUsuario;

  // O construtor agora obriga a passagem do nomeUsuario
  const TelaInicial({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoColeta', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        // Botão de Logout na AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            tooltip: 'Sair',
            onPressed: () {
              // pushReplacement impede que o usuário volte para cá ao deslogar
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TelaLogin()),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.recycling, size: 100, color: Colors.green),
            const SizedBox(height: 30),

            // Exibição do nome personalizado vindo do banco de dados
            Text(
              'Bem-vindo, $nomeUsuario!',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),
            const Text(
              'O que deseja fazer hoje no seu app de zeladoria?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            // Botão para ir para o formulário de coleta
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_location_alt, color: Colors.white),
                label: const Text(
                  'Solicitar Nova Coleta',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaFormulario(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Botão secundário (exemplo de histórico ou perfil)
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: () {
                // Futura funcionalidade
              },
              child: const Text(
                'Ver Meus Pedidos',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
