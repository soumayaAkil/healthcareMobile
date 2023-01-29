class Freq {
  final int id_freq;
  final String val_freq;
  final int id_user;
  final String date_add_freq;
  final String topic;

  Freq(
      {required this.id_freq,
        required this.val_freq,
        required this.id_user,
        required this.date_add_freq,
        required this.topic});

  factory Freq.fromJson(dynamic json) {
    return Freq(
      id_freq: json['id_freq'] as int,
      val_freq: json['val_freq'] as String,
      id_user: json['id_user'] as int,
      date_add_freq: json['date_add_freq'] as String,
      topic: json['topic'] as String,
    );
  }

  static List<Freq> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Freq.fromJson(data);
    }).toList();
  }


  @override
  String toString() {
    return 'Recipe {name:}';
  }
}
