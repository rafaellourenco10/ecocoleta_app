import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/tela_login.dart';

void main() {
  runApp(const EcoColetaApp());
}

class EcoColetaApp extends StatelessWidget {
  const EcoColetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoColeta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const TelaLogin(),
    );
  }
}
