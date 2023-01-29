class Oxy {
  final int id_oxy;
  final String val_oxy;
  final int id_user;
  final String date_add_oxy;
  final String topic_oxy;

  Oxy(
      {required this.id_oxy,
        required this.val_oxy,
        required this.id_user,
        required this.date_add_oxy,
        required this.topic_oxy});

  factory Oxy.fromJson(dynamic json) {
    return Oxy(
      id_oxy: json['id_oxy'] as int,
      val_oxy: json['val_oxy'] as String,
      id_user: json['id_user'] as int,
      date_add_oxy: json['date_add_oxy'] as String,
      topic_oxy: json['topic_oxy'] as String,
    );
  }

  static List<Oxy> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Oxy.fromJson(data);
    }).toList();
  }


  @override
  String toString() {
    return 'Recipe {name:}';
  }
}
