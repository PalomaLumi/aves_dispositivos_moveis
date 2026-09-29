import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import 'dados_comando_screen.dart';
import 'home_screen.dart';

class FinalizadoScreen extends StatefulWidget {
  const FinalizadoScreen({super.key});

  @override
  State<FinalizadoScreen> createState() => _FinalizadoScreenState();
}

class _FinalizadoScreenState extends State<FinalizadoScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final previsto = state.proximoCensoPrevisto;
    final restante = previsto == null ? Duration.zero : previsto.difference(DateTime.now());
    final seguro = restante.isNegative ? Duration.zero : restante;

    return Scaffold(
      appBar: AppBar(title: const Text('Censo finalizado')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle, size: 80),
            const SizedBox(height: 20),
            Text('Censo ${state.numeroCenso} finalizado com sucesso!', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            const Text('Próximo censo previsto em:', textAlign: TextAlign.center),
            Text(_tempo(seguro), textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                state.iniciarProximoCenso();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DadosComandoScreen()));
              },
              child: const Text('INICIAR PRÓXIMO CENSO AGORA'),
            ),
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (_) => false,
              ),
              child: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    );
  }

  String _tempo(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
