class RegistroAve {
  final String especieId;
  final String nomeExibicao;
  final int quantidade;
  final DateTime dataHora;
  final String metodo;
  final int? rodadaInstantanea;
  final bool identificacaoPendente;

  const RegistroAve({
    required this.especieId,
    required this.nomeExibicao,
    required this.quantidade,
    required this.dataHora,
    required this.metodo,
    this.rodadaInstantanea,
    this.identificacaoPendente = false,
  });
}
