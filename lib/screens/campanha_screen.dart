import 'package:flutter/material.dart';

import 'home_screen.dart';

class CampanhaScreen extends StatelessWidget {
  const CampanhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campanha')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Nome da campanha')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Projeto')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Embarcação')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Responsável / equipe')),
          const SizedBox(height: 24),
          const Text('A data e a hora dos censos serão obtidas automaticamente do aparelho.'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (_) => false,
            ),
            child: const Text('INICIAR CAMPANHA'),
          ),
        ],
      ),
    );
  }
}
