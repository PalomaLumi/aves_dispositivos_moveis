import 'package:flutter/material.dart';

import 'cadastro_observador_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.sailing, size: 90),
              const SizedBox(height: 24),
              Text('Monitoramento de Aves Marinhas',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              const Text(
                'Registro de censos embarcados, espécies e rota da campanha.',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CadastroObservadorScreen()),
                ),
                child: const Text('COMEÇAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
