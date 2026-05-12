import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_login.dart';
import 'tela_formulario.dart';

class TelaInicial extends StatefulWidget {
  final String nomeUsuario;
  const TelaInicial({super.key, required this.nomeUsuario});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List _coletas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    buscarColetas();
  }

  Future<void> buscarColetas() async {
    setState(() => _carregando = true);
    var url = Uri.parse('http://192.168.237.64/ecocoleta/listar_coletas.php');
    try {
      var resposta = await http.get(url);
      if (resposta.statusCode == 200) {
        setState(() {
          _coletas = json.decode(resposta.body);
          _carregando = false;
        });
      }
    } catch (e) {
      setState(() => _carregando = false);
    }
  }

  Future<void> deletarColeta(String id) async {
    var url = Uri.parse('http://192.168.237.64/ecocoleta/deletar_coleta.php');
    await http.post(url, body: {'id': id});
    buscarColetas();
  }

  // Função para mostrar o menu de opções (Editar/Excluir)
  void _mostrarOpcoes(Map coleta) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Editar Solicitação'),
              onTap: () {
                Navigator.pop(context);
                _mostrarDialogoEdicao(coleta);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Excluir Solicitação'),
              onTap: () {
                Navigator.pop(context);
                deletarColeta(coleta['id'].toString());
              },
            ),
          ],
        );
      },
    );
  }

  // Dialogo para editar os campos
  void _mostrarDialogoEdicao(Map coleta) {
    final editaTipo = TextEditingController(text: coleta['tipo_residuo']);
    final editaEndereco = TextEditingController(text: coleta['endereco']);
    final editaDesc = TextEditingController(text: coleta['descricao_item']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Coleta'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editaTipo,
                decoration: const InputDecoration(labelText: 'Tipo'),
              ),
              TextField(
                controller: editaDesc,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                controller: editaEndereco,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              var url = Uri.parse(
                'http://192.168.237.64/ecocoleta/editar_coleta.php',
              );
              await http.post(
                url,
                body: {
                  'id': coleta['id'].toString(),
                  'tipo_residuo': editaTipo.text,
                  'descricao_item': editaDesc.text,
                  'endereco': editaEndereco.text,
                },
              );
              if (!mounted) return;
              Navigator.pop(context);
              buscarColetas();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Coletas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: buscarColetas,
          ),
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
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.green[50],
            child: Text(
              'Bem-vindo, ${widget.nomeUsuario}!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _coletas.isEmpty
                ? const Center(child: Text("Nenhuma coleta encontrada."))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _coletas.length,
                    itemBuilder: (context, index) {
                      var coleta = _coletas[index];
                      return Card(
                        child: ListTile(
                          onTap: () =>
                              _mostrarOpcoes(coleta), // Abre o menu ao tocar
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          title: Text(coleta['tipo_residuo'] ?? 'Sem Tipo'),
                          subtitle: Text(coleta['endereco'] ?? ''),
                          trailing: const Icon(Icons.more_vert),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TelaFormulario()),
          );
          buscarColetas();
        },
        label: const Text('Nova Coleta', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}
