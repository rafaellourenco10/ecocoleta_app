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
      // Android 15 desenha o app atrás da barra de navegação; isso reserva o espaço em todas as telas
      builder: (context, child) => ColoredBox(
        color: AppColors.background,
        child: SafeArea(top: false, child: child!),
      ),
      home: const TelaLogin(),
    );
  }
}
