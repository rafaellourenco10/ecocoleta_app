import 'package:flutter/material.dart';
import '../core/api_exception.dart';
import '../core/app_theme.dart';
import '../core/coleta_service.dart';
import 'tela_login.dart';
import 'tela_formulario.dart';
import 'tela_perfil.dart';
import 'tela_dicas.dart';

class TelaInicial extends StatefulWidget {
  final String nomeUsuario;
  final String usuarioId;

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
    try {
      final dados = await ColetaService.listarPorUsuario(widget.usuarioId);
      setState(() {
        _quantidadePendentes = dados.length;
      });
    } catch (e) {
      debugPrint("Erro ao contar coletas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 20, 16, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Olá, ${widget.nomeUsuario}!',
                          style: textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'O que você deseja fazer hoje?',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaLogin()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                children: [
                  _buildMenuButton(
                    context,
                    title: 'Solicitar Coleta',
                    icon: Icons.add_location_alt_rounded,
                    color: AppColors.primary,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaFormulario(usuarioId: widget.usuarioId),
                        ),
                      );
                      _contarPendentes();
                    },
                  ),
                  _buildMenuButton(
                    context,
                    title: 'Minhas Coletas',
                    icon: Icons.list_alt_rounded,
                    color: AppColors.info,
                    badge: _quantidadePendentes > 0
                        ? _quantidadePendentes.toString()
                        : null,
                    onTap: () => _mostrarListaColetas(context),
                  ),
                  _buildMenuButton(
                    context,
                    title: 'Meu Perfil',
                    icon: Icons.person_outline_rounded,
                    color: AppColors.warning,
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
                  _buildMenuButton(
                    context,
                    title: 'Dicas de Descarte',
                    icon: Icons.lightbulb_outline_rounded,
                    color: AppColors.secondary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaDicas(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? badge,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 30, color: color),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            if (badge != null)
              Positioned(
                right: 14,
                top: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.danger,
                    borderRadius: BorderRadius.circular(20),
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

// COMPONENTE DA LISTA (AQUI VOLTAMOS COM O EDITAR E APAGAR)
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
    try {
      final dados = await ColetaService.listarPorUsuario(widget.usuarioId);
      setState(() {
        _coletas = dados;
        _carregando = false;
      });
    } catch (e) {
      setState(() => _carregando = false);
    }
  }

  Future<void> _deletar(String id) async {
    try {
      await ColetaService.deletar(id);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
    _buscar();
  }

  // Abre as opções ao tocar no item da lista
  void _mostrarOpcoes(Map coleta) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppColors.info),
              title: const Text('Editar Solicitação'),
              onTap: () {
                Navigator.pop(context);
                _dialogoEdicao(coleta);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
              title: const Text('Excluir Solicitação'),
              onTap: () {
                Navigator.pop(context);
                _deletar(coleta['id'].toString());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _dialogoEdicao(Map coleta) {
    final editaTipo = TextEditingController(text: coleta['tipo_residuo']);
    final editaDesc = TextEditingController(text: coleta['descricao_item']);
    final editaEnd = TextEditingController(text: coleta['endereco']);

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
              const SizedBox(height: 12),
              TextField(
                controller: editaDesc,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editaEnd,
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
            style: ElevatedButton.styleFrom(minimumSize: const Size(120, 44)),
            onPressed: () async {
              try {
                await ColetaService.editar(
                  coleta['id'].toString(),
                  tipoResiduo: editaTipo.text,
                  descricaoItem: editaDesc.text,
                  endereco: editaEnd.text,
                );
              } on ApiException catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.message), backgroundColor: Colors.red),
                );
                return;
              }
              if (!mounted) return;
              Navigator.pop(context);
              _buscar();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Minhas Solicitações",
            style: textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: _carregando
              ? const Center(child: CircularProgressIndicator())
              : _coletas.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text(
                        "Nenhuma solicitação encontrada.",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: widget.controller,
                  itemCount: _coletas.length,
                  itemBuilder: (context, i) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 6,
                    ),
                    child: ListTile(
                      onTap: () => _mostrarOpcoes(
                        _coletas[i],
                      ), // TOQUE PARA EDITAR/APAGAR
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.recycling_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        _coletas[i]['tipo_residuo'] ?? 'Material',
                        style: textTheme.titleMedium,
                      ),
                      subtitle: Text(_coletas[i]['endereco'] ?? ''),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
