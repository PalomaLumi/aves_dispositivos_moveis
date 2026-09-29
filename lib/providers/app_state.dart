import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../models/especie.dart';
import '../models/ponto_rota.dart';
import '../models/registro_ave.dart';
import '../repositories/especies_repository.dart';

class AppState extends ChangeNotifier {
  AppState(this._repository);

  final EspeciesRepository _repository;

  List<Especie> especies = [];
  final List<RegistroAve> registros = [];
  final List<PontoRota> rota = [];

  int numeroCenso = 1;
  DateTime? inicioCenso;
  DateTime? fimCenso;
  DateTime? proximoCensoPrevisto;
  int rodadaInstantanea = 1;

  StreamSubscription<Position>? _gpsSubscription;

  Future<void> inicializar() async {
    especies = await _repository.carregar();
    notifyListeners();
  }

  void iniciarCensoAgora() {
    inicioCenso = DateTime.now();
    fimCenso = null;
    proximoCensoPrevisto = null;
    rodadaInstantanea = 1;
    notifyListeners();
  }

  void registrar({
    required Especie especie,
    required int quantidade,
    required String metodo,
    int? rodada,
  }) {
    if (quantidade <= 0) return;
    registros.add(
      RegistroAve(
        especieId: especie.id,
        nomeExibicao: especie.nomeCientifico,
        quantidade: quantidade,
        dataHora: DateTime.now(),
        metodo: metodo,
        rodadaInstantanea: rodada,
        identificacaoPendente: especie.pendente,
      ),
    );
    notifyListeners();
  }

  int totalDaEspecie(String especieId, String metodo, {int? rodada}) {
    return registros
        .where((r) =>
            r.especieId == especieId &&
            r.metodo == metodo &&
            (rodada == null || r.rodadaInstantanea == rodada))
        .fold(0, (soma, r) => soma + r.quantidade);
  }

  Future<Especie> criarSpNova(String descricao) async {
    final especie = Especie(
      id: 'pend_${DateTime.now().microsecondsSinceEpoch}',
      nomeCientifico: descricao.trim().isEmpty ? 'Sp. nova' : descricao.trim(),
      nomeComum: 'Identificação pendente',
      pendente: true,
    );
    especies.add(especie);
    await _repository.salvar(especies);
    notifyListeners();
    return especie;
  }

  Future<void> adicionarEspecieComoAdmin(String cientifico, String comum) async {
    especies.add(
      Especie(
        id: 'adm_${DateTime.now().microsecondsSinceEpoch}',
        nomeCientifico: cientifico.trim(),
        nomeComum: comum.trim(),
      ),
    );
    await _repository.salvar(especies);
    notifyListeners();
  }

  void avancarRodadaInstantanea() {
    if (rodadaInstantanea < 10) {
      rodadaInstantanea++;
      notifyListeners();
    }
  }

  void finalizarCenso() {
    fimCenso = DateTime.now();
    proximoCensoPrevisto = fimCenso!.add(const Duration(minutes: 30));
    notifyListeners();
  }

  void iniciarProximoCenso() {
    numeroCenso++;
    iniciarCensoAgora();
  }

  Future<void> iniciarRastreamento() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }

    await _gpsSubscription?.cancel();
    _gpsSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
      ),
    ).listen((position) {
      rota.add(PontoRota(
        latitude: position.latitude,
        longitude: position.longitude,
        dataHora: DateTime.now(),
      ));
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _gpsSubscription?.cancel();
    super.dispose();
  }
}
