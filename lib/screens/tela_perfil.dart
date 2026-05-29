import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/api_constants.dart';

class TelaPerfil extends StatefulWidget {
  final String usuarioId;
  const TelaPerfil({super.key, required this.usuarioId});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  bool _carregando = true;
  bool _editando = false;

  @override
  void initState() {
    super.initState();
    _buscarDadosPerfil();
  }

  // Busca os dados do usuário no MySQL via PHP
  Future<void> _buscarDadosPerfil() async {
    var url = Uri.parse(ApiConstants.obterPerfil(widget.usuarioId));
    try {
      var res = await http.get(url);
      var dados = json.decode(res.body);
      setState(() {
        _nomeController.text = dados['nome'] ?? '';
        _emailController.text = dados['email'] ?? '';
        _telefoneController.text = dados['telefone'] ?? '';
        _enderecoController.text = dados['endereco'] ?? '';
        _carregando = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar perfil: $e");
      setState(() => _carregando = false);
    }
  }

  // Envia as alterações para o banco de dados
  Future<void> _atualizarPerfil() async {
    setState(() => _carregando = true);
    var url = Uri.parse(ApiConstants.atualizarPerfil(widget.usuarioId));
    try {
      await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': _nomeController.text,
          'email': _emailController.text,
          'telefone': _telefoneController.text,
          'endereco': _enderecoController.text,
        }),
      );
      setState(() {
        _editando = false;
        _carregando = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _carregando = false);
      debugPrint("Erro ao atualizar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              _editando ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              if (_editando) {
                _atualizarPerfil();
              } else {
                setState(() => _editando = true);
              }
            },
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Hero(
                    tag: 'profile-pic',
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildField(
                    label: 'Nome Completo',
                    controller: _nomeController,
                    icon: Icons.person_outline,
                  ),
                  _buildField(
                    label: 'E-mail',
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _buildField(
                    label: 'Telefone',
                    controller: _telefoneController,
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildField(
                    label: 'Endereço Principal',
                    controller: _enderecoController,
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 20),
                  if (_editando)
                    Text(
                      "Você está no modo de edição",
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        enabled: _editando,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.green[700]),
          border: const OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          filled: !_editando,
          fillColor: _editando ? Colors.white : Colors.grey[50],
        ),
      ),
    );
  }
}
