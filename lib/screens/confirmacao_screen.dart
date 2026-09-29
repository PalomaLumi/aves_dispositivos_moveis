import 'package:flutter/material.dart';

import 'campanha_screen.dart';

class ConfirmacaoScreen extends StatelessWidget {
  const ConfirmacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmação')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Digite o código de confirmação do observador.'),
            const SizedBox(height: 16),
            const TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Código'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CampanhaScreen()),
              ),
              child: const Text('CONFIRMAR'),
            ),
          ],
        ),
      ),
    );
  }
}
