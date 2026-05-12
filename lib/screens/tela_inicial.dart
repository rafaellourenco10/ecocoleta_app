import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_login.dart';
import 'tela_formulario.dart';
import 'tela_perfil.dart'; // IMPORTANTE: Importe a nova tela aqui

class TelaInicial extends StatefulWidget {
  final String nomeUsuario;
  final String usuarioId; // Recebe o ID do banco de dados

  const TelaInicial({
    super.key,
    required this.nomeUsuario,
    required this.usuarioId,
  });

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _quantidadePendentes = 0;

  @override
  void initState() {
    super.initState();
    _contarPendentes();
  }

  Future<void> _contarPendentes() async {
    // Agora filtramos as coletas pelo ID do usuário logado
    var url = Uri.parse(
      'http://192.168.237.64/ecocoleta/listar_coletas.php?usuario_id=${widget.usuarioId}',
    );
    try {
      var resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        List dados = json.decode(resposta.body);
        setState(() {
          _quantidadePendentes = dados.length;
        });
      }
    } catch (e) {
      debugPrint("Erro ao contar coletas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'EcoColeta',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaLogin()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header com degradê verde
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, ${widget.nomeUsuario}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'O que você deseja fazer hoje?',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Grid de Opções do Dashboard
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  // Solicitar Coleta
                  _buildMenuButton(
                    context,
                    title: 'Solicitar Coleta',
                    icon: Icons.add_location_alt_rounded,
                    color: Colors.green.shade600,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaFormulario(),
                        ),
                      );
                      _contarPendentes();
                    },
                  ),

                  // Ver Coletas (Com Badge de quantidade)
                  _buildMenuButton(
                    context,
                    title: 'Minhas Coletas',
                    icon: Icons.list_alt_rounded,
                    color: Colors.blue.shade600,
                    badge: _quantidadePendentes > 0
                        ? _quantidadePendentes.toString()
                        : null,
                    onTap: () => _mostrarListaColetas(context),
                  ),

                  // MEU PERFIL (Agora funcional!)
                  _buildMenuButton(
                    context,
                    title: 'Meu Perfil',
                    icon: Icons.person_outline,
                    color: Colors.orange.shade600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaPerfil(usuarioId: widget.usuarioId),
                        ),
                      );
                    },
                  ),

                  // Dicas
                  _buildMenuButton(
                    context,
                    title: 'Dicas de Descarte',
                    icon: Icons.lightbulb_outline,
                    color: Colors.teal.shade600,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para os botões do menu
  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 45, color: color),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null)
              Positioned(
                right: 15,
                top: 15,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Abre a lista em um BottomSheet
  void _mostrarListaColetas(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        expand: false,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: _ListaColetasWidget(
            controller: controller,
            usuarioId: widget.usuarioId,
          ),
        ),
      ),
    ).then((_) => _contarPendentes());
  }
}

// Widget Interno para a Lista
class _ListaColetasWidget extends StatefulWidget {
  final ScrollController controller;
  final String usuarioId;
  const _ListaColetasWidget({
    required this.controller,
    required this.usuarioId,
  });

  @override
  State<_ListaColetasWidget> createState() => _ListaColetasWidgetState();
}

class _ListaColetasWidgetState extends State<_ListaColetasWidget> {
  List _coletas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscar();
  }

  Future<void> _buscar() async {
    setState(() => _carregando = true);
    var url = Uri.parse(
      'http://192.168.237.64/ecocoleta/listar_coletas.php?usuario_id=${widget.usuarioId}',
    );
    try {
      var res = await http.get(url);
      setState(() {
        _coletas = json.decode(res.body);
        _carregando = false;
      });
    } catch (e) {
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Minhas Solicitações",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: _carregando
              ? const Center(child: CircularProgressIndicator())
              : _coletas.isEmpty
              ? const Center(child: Text("Nenhuma solicitação encontrada."))
              : ListView.builder(
                  controller: widget.controller,
                  itemCount: _coletas.length,
                  itemBuilder: (context, i) => ListTile(
                    leading: const Icon(Icons.recycling, color: Colors.green),
                    title: Text(_coletas[i]['tipo_residuo'] ?? 'Material'),
                    subtitle: Text(_coletas[i]['endereco'] ?? ''),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
        ),
      ],
    );
  }
}
