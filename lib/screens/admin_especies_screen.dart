import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class AdminEspeciesScreen extends StatelessWidget {
  const AdminEspeciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Administração de espécies')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _adicionar(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova espécie'),
      ),
      body: ListView.builder(
        itemCount: state.especies.length,
        itemBuilder: (_, i) {
          final e = state.especies[i];
          return ListTile(
            leading: Icon(e.pendente ? Icons.pending_actions : Icons.check_circle_outline),
            title: Text(e.nomeCientifico, style: const TextStyle(fontStyle: FontStyle.italic)),
            subtitle: Text(e.nomeComum),
            trailing: e.pendente ? const Chip(label: Text('PENDENTE')) : null,
          );
        },
      ),
    );
  }

  Future<void> _adicionar(BuildContext context) async {
    final cientifico = TextEditingController();
    final comum = TextEditingController();
    final salvar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cadastrar espécie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: cientifico, decoration: const InputDecoration(labelText: 'Nome científico')),
            const SizedBox(height: 12),
            TextField(controller: comum, decoration: const InputDecoration(labelText: 'Nome comum')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Salvar')),
        ],
      ),
    );
    if (salvar == true && context.mounted && cientifico.text.trim().isNotEmpty) {
      await context.read<AppState>().adicionarEspecieComoAdmin(cientifico.text, comum.text);
    }
  }
}
