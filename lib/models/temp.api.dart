import 'dart:convert';

import 'package:healthcare/models/temp.dart';
import 'package:http/http.dart' as http;

import '../config.dart';


class TempApi {

  static Future<List<Temp>> getAllTemp() async {
    // var uri = Uri.http("http://localhost:6000/offre/GetAllOffres/");

    final response = await http.get(TEMP_URL +"/GetAllTemp");
    print("******************************");
    var data = jsonDecode(response.body);

    print(data);
    List _temp = [];

    for (var i in data) {
      print("******************************");
      print(i);
      _temp.add(i);
    }

    return Temp.recipesFromSnapshot(_temp);
  }

}
