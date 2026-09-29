import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import 'dados_comando_screen.dart';
import 'mapa_screen.dart';
import 'admin_especies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Censo de Aves Marinhas')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Campanha em andamento', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Próximo registro: Censo ${state.numeroCenso}'),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                state.iniciarCensoAgora();
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DadosComandoScreen()));
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('INICIAR CENSO'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapaScreen())),
              icon: const Icon(Icons.map),
              label: const Text('VER ROTA DA CAMPANHA'),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminEspeciesScreen())),
              icon: const Icon(Icons.admin_panel_settings),
              label: const Text('Administração de espécies'),
            ),
          ],
        ),
      ),
    );
  }
}
