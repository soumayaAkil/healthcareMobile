class Temp {
  final int id_temp;
  final String val_temp;
  final int id_user;
  final String date_add_temp;
  final String topic;

  Temp(
      {required this.id_temp,
        required this.val_temp,
        required this.id_user,
        required this.date_add_temp,
        required this.topic});

  factory Temp.fromJson(dynamic json) {
    return Temp(
      id_temp: json['id_temp'] as int,
      val_temp: json['val_temp'] as String,
      id_user: json['id_user'] as int,
      date_add_temp: json['date_add_temp'] as String,
      topic: json['topic'] as String,
    );
  }

  static List<Temp> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Temp.fromJson(data);
    }).toList();
  }


  @override
  String toString() {
    return 'Recipe {name:}';
  }
}
