import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'repositories/especies_repository.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final state = AppState(EspeciesRepository());
  await state.inicializar();

  runApp(
    ChangeNotifierProvider.value(
      value: state,
      child: const CensoAvesApp(),
    ),
  );
}

class CensoAvesApp extends StatelessWidget {
  const CensoAvesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Censo de Aves Marinhas',
      theme: AppTheme.light,
      home: const WelcomeScreen(),
    );
  }
}
