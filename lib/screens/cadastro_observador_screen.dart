import 'package:flutter/material.dart';

import 'confirmacao_screen.dart';

class CadastroObservadorScreen extends StatelessWidget {
  const CadastroObservadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro do observador')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Nome completo')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'E-mail')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: 'Instituição')),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ConfirmacaoScreen()),
            ),
            child: const Text('CONTINUAR'),
          ),
        ],
      ),
    );
  }
}
