import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const TelaLogin(),
    );
  }
}
