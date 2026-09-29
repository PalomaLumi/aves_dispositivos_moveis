import 'package:flutter/material.dart';

class ContadorEspecie extends StatefulWidget {
  const ContadorEspecie({super.key, required this.total, required this.onAdicionar});

  final int total;
  final ValueChanged<int> onAdicionar;

  @override
  State<ContadorEspecie> createState() => _ContadorEspecieState();
}

class _ContadorEspecieState extends State<ContadorEspecie> {
  int quantidade = 1;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '1');
  }

  void atualizar(int valor) {
    final seguro = valor < 1 ? 1 : valor;
    setState(() {
      quantidade = seguro;
      controller.text = seguro.toString();
      controller.selection = TextSelection.collapsed(offset: controller.text.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Número de indivíduos'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filledTonal(
              onPressed: () => atualizar(quantidade - 1),
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 80,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (value) => quantidade = int.tryParse(value) ?? 1,
              ),
            ),
            IconButton.filledTonal(
              onPressed: () => atualizar(quantidade + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            widget.onAdicionar(quantidade);
            atualizar(1);
          },
          child: const Text('ADICIONAR'),
        ),
        const SizedBox(height: 12),
        Text('Total observado: ${widget.total}', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
