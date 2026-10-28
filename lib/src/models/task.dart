/// Une échéance à rendre (TP, projet, examen…).
class Task {
  final String id;
  final String titre;
  final String coursId;
  final DateTime echeance;
  final String? description; // facultative
  final bool terminee;

  const Task({
    required this.id,
    required this.titre,
    required this.coursId,
    required this.echeance,
    this.description,
    this.terminee = false,
  });

  /// Copie avec un ou plusieurs champs modifiés : l'objet d'origine ne change pas.
  Task copyWith({
    String? titre,
    String? coursId,
    DateTime? echeance,
    String? description,
    bool? terminee,
  }) =>
      Task(
        id: id,
        titre: titre ?? this.titre,
        coursId: coursId ?? this.coursId,
        echeance: echeance ?? this.echeance,
        description: description ?? this.description,
        terminee: terminee ?? this.terminee,
      );

  /// Lève une [FormatException] si un champ obligatoire manque ou a le mauvais type.
  factory Task.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final titre = json['titre'];
    final coursId = json['coursId'];
    final echeance = json['echeance'];
    final description = json['description'];
    final terminee = json['terminee'] ?? false;

    if (id is! String ||
        titre is! String ||
        coursId is! String ||
        echeance is! String ||
        (description != null && description is! String) ||
        terminee is! bool) {
      throw FormatException('Task invalide', json);
    }

    return Task(
      id: id,
      titre: titre,
      coursId: coursId,
      echeance: DateTime.parse(echeance), // FormatException si date invalide
      description: description as String?,
      terminee: terminee,
    );
  }

  bool get enRetard => !terminee && echeance.isBefore(DateTime.now());

  @override
  String toString() =>
      'Task($titre, ${echeance.toIso8601String()}${terminee ? ', faite' : ''})';
}
