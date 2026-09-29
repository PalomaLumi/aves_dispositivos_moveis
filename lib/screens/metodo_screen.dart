import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/especie.dart';
import '../providers/app_state.dart';
import '../widgets/contador_especie.dart';
import 'finalizado_screen.dart';

class MetodoScreen extends StatefulWidget {
  const MetodoScreen({super.key, required this.metodo});
  final String metodo;

  @override
  State<MetodoScreen> createState() => _MetodoScreenState();
}

class _MetodoScreenState extends State<MetodoScreen> {
  final busca = TextEditingController();
  Duration restante = Duration.zero;
  Timer? timer;

  bool get temporizado => widget.metodo == 'continuo' || widget.metodo == 'instantaneo';

  @override
  void initState() {
    super.initState();
    if (widget.metodo == 'continuo') restante = const Duration(minutes: 10);
    if (widget.metodo == 'instantaneo') restante = const Duration(minutes: 1);
    if (temporizado) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted || restante.inSeconds <= 0) return;
        setState(() => restante -= const Duration(seconds: 1));
      });
    }
  }

  String get titulo => switch (widget.metodo) {
        'seguidoras' => 'Aves seguidoras',
        'continuo' => 'Censo contínuo',
        _ => 'Censo instantâneo',
      };

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final filtro = busca.text.toLowerCase();
    final especies = state.especies.where((e) =>
        e.nomeCientifico.toLowerCase().contains(filtro) || e.nomeComum.toLowerCase().contains(filtro)).toList();

    return Scaffold(
      appBar: AppBar(title: Text('$titulo — Censo ${state.numeroCenso}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (widget.metodo == 'continuo')
            Center(child: Text('Janela de 10 min: ${_tempo(restante)}', style: Theme.of(context).textTheme.titleLarge)),
          if (widget.metodo == 'instantaneo')
            Center(
              child: Text('Contagem ${state.rodadaInstantanea} de 10 — ${_tempo(restante)}', style: Theme.of(context).textTheme.titleLarge),
            ),
          const SizedBox(height: 12),
          TextField(
            controller: busca,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: 'Buscar espécie'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _novaEspecie(context),
            icon: const Icon(Icons.add),
            label: const Text('SP. NOVA / NÃO ENCONTRADA'),
          ),
          const SizedBox(height: 12),
          ...especies.map((e) => _cardEspecie(context, state, e)),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _avancar(context, state),
            child: Text(widget.metodo == 'instantaneo' ? 'ENVIAR ESTA CONTAGEM' : 'ENVIAR E CONTINUAR'),
          ),
        ],
      ),
    );
  }

  Widget _cardEspecie(BuildContext context, AppState state, Especie especie) {
    final rodada = widget.metodo == 'instantaneo' ? state.rodadaInstantanea : null;
    final total = state.totalDaEspecie(especie.id, widget.metodo, rodada: rodada);
    return Card(
      child: ExpansionTile(
        title: Text(especie.nomeCientifico, style: const TextStyle(fontStyle: FontStyle.italic)),
        subtitle: Text(especie.pendente ? 'Identificação pendente' : especie.nomeComum),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ContadorEspecie(
              total: total,
              onAdicionar: (qtd) => state.registrar(
                especie: especie,
                quantidade: qtd,
                metodo: widget.metodo,
                rodada: rodada,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _novaEspecie(BuildContext context) async {
    final controller = TextEditingController();
    final descricao = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sp. nova'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Descrição ou nome provisório'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, controller.text), child: const Text('Criar pendente')),
        ],
      ),
    );
    if (descricao != null && context.mounted) {
      await context.read<AppState>().criarSpNova(descricao);
    }
  }

  void _avancar(BuildContext context, AppState state) {
    if (widget.metodo == 'seguidoras') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MetodoScreen(metodo: 'continuo')));
      return;
    }
    if (widget.metodo == 'continuo') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MetodoScreen(metodo: 'instantaneo')));
      return;
    }
    if (state.rodadaInstantanea < 10) {
      state.avancarRodadaInstantanea();
      setState(() => restante = const Duration(minutes: 1));
    } else {
      state.finalizarCenso();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FinalizadoScreen()));
    }
  }

  String _tempo(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    timer?.cancel();
    busca.dispose();
    super.dispose();
  }
}
