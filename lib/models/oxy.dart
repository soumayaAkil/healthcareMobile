class Val {

  final String val_temp;
  final String val_press;
  final String val_dist;

  Val(
      {required this.val_temp,
        required this.val_press,
        required this.val_dist,
});

  factory Val.fromJson(dynamic json) {
    return Val(
      val_temp: json['val_temp'] as String,
      val_press: json['val_press'] as String,
      val_dist: json['val_dist'] as String,
    );
  }

  static List<Val> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Val.fromJson(data);
    }).toList();
  }


  @override
  String toString() {
    return 'Recipe {name:}';
  }
}
