import 'package:flutter/material.dart';
import '../core/api_exception.dart';
import '../core/app_theme.dart';
import '../core/usuario_service.dart';
import '../core/validators.dart';

class TelaPerfil extends StatefulWidget {
  final String usuarioId;
  const TelaPerfil({super.key, required this.usuarioId});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final _formKey = GlobalKey<FormState>();
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

  Future<void> _buscarDadosPerfil() async {
    try {
      final dados = await UsuarioService.obterPerfil(widget.usuarioId);
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
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);
    try {
      await UsuarioService.atualizarPerfil(
        widget.usuarioId,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        endereco: _enderecoController.text,
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
    } on ApiException catch (e) {
      setState(() => _carregando = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      setState(() => _carregando = false);
      debugPrint("Erro ao atualizar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 220,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  actions: [
                    IconButton(
                      icon: Icon(_editando ? Icons.check_rounded : Icons.edit_outlined),
                      onPressed: () {
                        if (_editando) {
                          _atualizarPerfil();
                        } else {
                          setState(() => _editando = true);
                        }
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryDark, AppColors.primary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                radius: 46,
                                backgroundColor: AppColors.primarySoft,
                                child: Icon(Icons.person, size: 50, color: AppColors.primary),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _nomeController.text.isEmpty ? 'Meu Perfil' : _nomeController.text,
                              style: textTheme.titleLarge?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_editando)
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.edit_note_rounded, color: AppColors.warning, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Você está no modo de edição',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: AppColors.warning,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          _buildField(
                            label: 'Nome Completo',
                            controller: _nomeController,
                            icon: Icons.person_outline,
                            validator: (v) => Validators.obrigatorio(v, campo: 'Nome'),
                          ),
                          _buildField(
                            label: 'E-mail',
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.email,
                          ),
                          _buildField(
                            label: 'Telefone',
                            controller: _telefoneController,
                            icon: Icons.phone_android_outlined,
                            keyboardType: TextInputType.phone,
                            validator: Validators.telefone,
                          ),
                          _buildField(
                            label: 'Endereço Principal',
                            controller: _enderecoController,
                            icon: Icons.map_outlined,
                            validator: (v) => Validators.obrigatorio(v, campo: 'Endereço'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: _editando,
        keyboardType: keyboardType,
        validator: _editando ? validator : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
