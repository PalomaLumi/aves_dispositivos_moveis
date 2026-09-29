import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/especie.dart';

class EspeciesRepository {
  static const _key = 'especies_catalogo';

  static const List<Especie> _sementes = [
    Especie(id: 'arde_grav', nomeCientifico: 'Ardenna gravis', nomeComum: 'Pardela-de-barrete'),
    Especie(id: 'thal_maxi', nomeCientifico: 'Thalasseus maximus', nomeComum: 'Trinta-réis-real'),
    Especie(id: 'thal_acuf', nomeCientifico: 'Thalasseus acuflavidus', nomeComum: 'Trinta-réis-de-bando'),
    Especie(id: 'ster_hiru', nomeCientifico: 'Sterna hirundinacea', nomeComum: 'Trinta-réis-de-bico-vermelho'),
  ];

  Future<List<Especie>> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);

    if (raw == null) {
      await salvar(_sementes);
      return List.of(_sementes);
    }

    final lista = (jsonDecode(raw) as List)
        .map((e) => Especie.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
    return lista;
  }

  Future<void> salvar(List<Especie> especies) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(especies.map((e) => e.toMap()).toList());
    await prefs.setString(_key, raw);
  }
}
