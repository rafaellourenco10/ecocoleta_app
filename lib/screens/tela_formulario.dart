import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../core/api_constants.dart';

class TelaFormulario extends StatefulWidget {
  final String usuarioId;
  const TelaFormulario({super.key, required this.usuarioId});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  // Controladores de texto
  final _enderecoController = TextEditingController();
  final _descricaoController = TextEditingController();

  // Variáveis para seleção e imagem
  String? _tipoResiduo;
  String? _volume;
  String? _acondicionamento;
  File? _imagemSelecionada;

  // Listas de opções
  final List<String> _tipos = [
    'Orgânico',
    'Reciclável',
    'Construção Civil',
    'Infectante',
    'Eletrônico',
  ];
  final List<String> _volumes = [
    'Até 0,5m³',
    'Entre 0,5m³ e 1m³',
    'Acima de 1m³',
  ];
  final List<String> _formasAcondicionamento = [
    'Contêiner',
    'Sacos Plásticos',
    'Enfardado',
    'Solto',
  ];

  bool _estaCarregando = false;

  // Função para abrir a câmera e tirar foto
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final foto = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // Reduz qualidade para não pesar no envio
    );

    if (foto != null) {
      setState(() {
        _imagemSelecionada = File(foto.path);
      });
    }
  }

  Future<void> enviarDados() async {
    // Remove espaços vazios acidentais
    String endereco = _enderecoController.text.trim();
    String descricao = _descricaoController.text.trim();

    // Validação rigorosa
    if (_tipoResiduo == null ||
        _volume == null ||
        _acondicionamento == null ||
        endereco.isEmpty ||
        descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos e a descrição!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _estaCarregando = true);

    var url = Uri.parse(ApiConstants.cadastrarColeta);
    
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var resposta = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'usuario_id': widget.usuarioId,
          'tipo_residuo': _tipoResiduo,
          'volume': _volume,
          'acondicionamento': _acondicionamento,
          'descricao_item': descricao,
          'endereco': endereco,
          'url_foto': _imagemSelecionada != null ? 'foto_capturada.jpg' : '',
        }),
      );

      if (resposta.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solicitação enviada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Volta para a tela inicial
      } else {
        if (!mounted) return;
        String mensagemErro;
        try {
          var erro = json.decode(resposta.body);
          mensagemErro = erro['error'] ?? 'Erro ${resposta.statusCode}';
        } catch (_) {
          mensagemErro = 'Erro no servidor: ${resposta.statusCode}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagemErro),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro de conexão. Verifique sua internet e tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _estaCarregando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Solicitação',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Área de captura de foto
            const Text(
              "Foto do Resíduo (Opcional)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _tirarFoto,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _imagemSelecionada == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_enhance,
                            size: 50,
                            color: Colors.green,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Toque para abrir a câmera",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _imagemSelecionada!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 25),

            // Seleção de Tipo
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tipo de Resíduo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              value: _tipoResiduo,
              items: _tipos
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) => setState(() => _tipoResiduo = val),
            ),
            const SizedBox(height: 15),

            // Seleção de Volume
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Volume Estimado',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assessment),
              ),
              value: _volume,
              items: _volumes
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (val) => setState(() => _volume = val),
            ),
            const SizedBox(height: 15),

            // Seleção de Acondicionamento
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Acondicionamento',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory_2),
              ),
              value: _acondicionamento,
              items: _formasAcondicionamento
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
              onChanged: (val) => setState(() => _acondicionamento = val),
            ),
            const SizedBox(height: 15),

            // Campo de Descrição (Essencial para o Banco de Dados)
            TextField(
              controller: _descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descrição detalhada dos itens',
                hintText: 'Ex: Restos de poda de árvore e móveis velhos...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 15),

            // Campo de Endereço
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço da Coleta',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 30),

            // Botão Confirmar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _estaCarregando ? null : enviarDados,
              child: _estaCarregando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Confirmar Solicitação',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
