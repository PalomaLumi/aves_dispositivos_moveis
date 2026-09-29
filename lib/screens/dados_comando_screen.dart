import 'package:flutter/material.dart';

import 'metodo_screen.dart';

class DadosComandoScreen extends StatefulWidget {
  const DadosComandoScreen({super.key});

  @override
  State<DadosComandoScreen> createState() => _DadosComandoScreenState();
}

class _DadosComandoScreenState extends State<DadosComandoScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados do comando')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Preencha novamente a cada novo censo.'),
            const SizedBox(height: 16),
            ...['Rumo (°)', 'Velocidade do navio', 'Direção do vento (°)', 'Velocidade do vento', 'Pressão atmosférica', 'Estado do mar']
                .map((label) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextFormField(decoration: InputDecoration(labelText: label)),
                    )),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Observações'),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MetodoScreen(metodo: 'seguidoras')),
              ),
              child: const Text('SALVAR E CONTINUAR'),
            ),
          ],
        ),
      ),
    );
  }
}
