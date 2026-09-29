class Especie {
  final String id;
  final String nomeCientifico;
  final String nomeComum;
  final bool pendente;

  const Especie({
    required this.id,
    required this.nomeCientifico,
    required this.nomeComum,
    this.pendente = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'nomeCientifico': nomeCientifico,
        'nomeComum': nomeComum,
        'pendente': pendente,
      };

  factory Especie.fromMap(Map<String, dynamic> map) => Especie(
        id: map['id'] as String,
        nomeCientifico: map['nomeCientifico'] as String,
        nomeComum: map['nomeComum'] as String,
        pendente: map['pendente'] as bool? ?? false,
      );
}
