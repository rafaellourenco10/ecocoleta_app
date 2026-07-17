import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import '../core/api_exception.dart';
import '../core/app_theme.dart';
import '../core/coleta_service.dart';
import '../core/validators.dart';

class TelaFormulario extends StatefulWidget {
  final String usuarioId;
  const TelaFormulario({super.key, required this.usuarioId});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();

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
      maxWidth: 1024,
      maxHeight: 1024,
    );

    if (foto != null) {
      setState(() {
        _imagemSelecionada = File(foto.path);
      });
    }
  }

  Future<void> enviarDados() async {
    if (!_formKey.currentState!.validate()) return;

    // Remove espaços vazios acidentais
    String endereco = _enderecoController.text.trim();
    String descricao = _descricaoController.text.trim();

    setState(() => _estaCarregando = true);

    try {
      String fotoBase64 = '';
      if (_imagemSelecionada != null) {
        final bytes = await _imagemSelecionada!.readAsBytes();
        fotoBase64 = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      }

      await ColetaService.cadastrar(
        usuarioId: widget.usuarioId,
        tipoResiduo: _tipoResiduo!,
        volume: _volume!,
        acondicionamento: _acondicionamento!,
        descricaoItem: descricao,
        endereco: endereco,
        urlFoto: fotoBase64,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Solicitação enviada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Volta para a tela inicial
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _estaCarregando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Nova Solicitação')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Foto do resíduo (opcional)",
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _tirarFoto,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _imagemSelecionada == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_enhance_rounded,
                              size: 44,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Toque para abrir a câmera",
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _imagemSelecionada!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 25),

              // Seleção de Tipo
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Resíduo',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                value: _tipoResiduo,
                items: _tipos
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => _tipoResiduo = val),
                validator: (v) => v == null ? 'Selecione o tipo de resíduo' : null,
              ),
              const SizedBox(height: 16),

              // Seleção de Volume
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Volume Estimado',
                  prefixIcon: Icon(Icons.assessment_outlined),
                ),
                value: _volume,
                items: _volumes
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (val) => setState(() => _volume = val),
                validator: (v) => v == null ? 'Selecione o volume estimado' : null,
              ),
              const SizedBox(height: 16),

              // Seleção de Acondicionamento
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Acondicionamento',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                value: _acondicionamento,
                items: _formasAcondicionamento
                    .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                    .toList(),
                onChanged: (val) => setState(() => _acondicionamento = val),
                validator: (v) => v == null ? 'Selecione o acondicionamento' : null,
              ),
              const SizedBox(height: 16),

              // Campo de Descrição (Essencial para o Banco de Dados)
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição detalhada dos itens',
                  hintText: 'Ex: Restos de poda de árvore e móveis velhos...',
                  alignLabelWithHint: true,
                ),
                validator: (v) => Validators.obrigatorio(v, campo: 'Descrição'),
              ),
              const SizedBox(height: 16),

              // Campo de Endereço
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço da Coleta',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (v) => Validators.obrigatorio(v, campo: 'Endereço'),
              ),
              const SizedBox(height: 30),

              // Botão Confirmar
              ElevatedButton(
                onPressed: _estaCarregando ? null : enviarDados,
                child: _estaCarregando
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.4,
                        ),
                      )
                    : const Text('Confirmar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
