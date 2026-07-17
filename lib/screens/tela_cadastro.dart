import 'package:flutter/material.dart';
import '../core/api_exception.dart';
import '../core/usuario_service.dart';
import '../core/validators.dart';
class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar os dados digitados
  final _nomeController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _estaCarregando = false; // Variável para controlar a animação do botão

  Future<void> enviarCadastro() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _estaCarregando = true;
    });

    try {
      await UsuarioService.registrar(
        nome: _nomeController.text,
        cpfCnpj: _cpfCnpjController.text,
        endereco: _enderecoController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
        senha: _senhaController.text,
      );

      if (!mounted) return;
      // Mostra aviso de sucesso e volta para a tela de Login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _estaCarregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Complete seus dados',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Leva menos de um minuto',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo ou Razão Social',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => Validators.obrigatorio(v, campo: 'Nome'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _cpfCnpjController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF ou CNPJ',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: Validators.cpfCnpj,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(
                  labelText: 'Endereço Completo',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (v) => Validators.obrigatorio(v, campo: 'Endereço'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Telefone / WhatsApp',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: Validators.telefone,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: Validators.email,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: Validators.senha,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _estaCarregando ? null : enviarCadastro,
                child: _estaCarregando
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Finalizar Cadastro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
