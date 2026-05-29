import 'package:flutter/material.dart';

class TelaDicas extends StatelessWidget {
  const TelaDicas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas de Descarte', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDicaCard(
            context,
            titulo: 'Eletrônicos',
            icone: Icons.computer,
            cor: Colors.blueGrey,
            descricao: 'Nunca descarte em lixo comum. Eles contêm metais pesados que contaminam o solo. Procure sempre agendar a coleta ou levar a um ecoponto.',
          ),
          _buildDicaCard(
            context,
            titulo: 'Óleo de Cozinha',
            icone: Icons.local_drink,
            cor: Colors.amber,
            descricao: 'Um litro de óleo contamina até 25 mil litros de água! Espere esfriar, guarde em uma garrafa PET e entregue para coleta especial ou ONGs de sabão.',
          ),
          _buildDicaCard(
            context,
            titulo: 'Pilhas e Baterias',
            icone: Icons.battery_alert,
            cor: Colors.redAccent,
            descricao: 'São extremamente tóxicas. Lojas de eletrônicos, supermercados e farmácias geralmente possuem coletores específicos (Logística Reversa).',
          ),
          _buildDicaCard(
            context,
            titulo: 'Vidros Quebrados',
            icone: Icons.warning,
            cor: Colors.blue,
            descricao: 'Para não machucar os coletores, enrole os cacos em jornal ou coloque dentro de uma caixa de papelão/garrafa PET cortada com um aviso.',
          ),
          _buildDicaCard(
            context,
            titulo: 'Remédios Vencidos',
            icone: Icons.medical_services,
            cor: Colors.green,
            descricao: 'Não jogue no vaso ou lixo comum, pois contamina a água com resíduos químicos. Leve a qualquer farmácia para o descarte correto.',
          ),
        ],
      ),
    );
  }

  Widget _buildDicaCard(BuildContext context, {required String titulo, required IconData icone, required Color cor, required String descricao}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: cor.withOpacity(0.2),
            child: Icon(icone, color: cor),
          ),
          title: Text(
            titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          children: [
            Text(
              descricao,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
