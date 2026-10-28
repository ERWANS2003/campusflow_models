import '../models/task.dart';

/// Le contrat : l'écran ne sait pas d'où viennent les tâches.
/// Plus tard, un ApiTaskRepository implémentera la même interface.
abstract interface class TaskRepository {
  Future<List<Task>> chargerTaches();
}

/// Dépôt simulé : renvoie du JSON en dur après un délai, comme un vrai serveur.
class FakeTaskRepository implements TaskRepository {
  final Duration delai;
  final bool echec; // true pour simuler une coupure réseau

  const FakeTaskRepository({
    this.delai = const Duration(seconds: 1),
    this.echec = false,
  });

  static const _json = <Map<String, dynamic>>[
    {
      'id': 't1',
      'titre': 'Rendu TP Dart',
      'coursId': 'mobile',
      'echeance': '2026-10-29T23:59:00',
    },
    {
      'id': 't2',
      'titre': 'Projet Flutter',
      'coursId': 'mobile',
      'echeance': '2026-10-30T17:00:00',
      'description': 'Maquette + 5 écrans',
    },
    {
      'id': 't3',
      'titre': 'Examen UX',
      'coursId': 'ux',
      'echeance': '2026-11-02T08:00:00',
      'terminee': true,
    },
  ];

  @override
  Future<List<Task>> chargerTaches() async {
    await Future.delayed(delai);
    if (echec) {
      throw Exception('Réseau indisponible');
    }
    return _json.map(Task.fromJson).toList();
  }
}
