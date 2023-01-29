import 'dart:convert';

import 'package:healthcare/models/oxy.dart';
import 'package:healthcare/models/temp.dart';
import 'package:http/http.dart' as http;

import '../config.dart';


class OxyyApi {

  static Future<List<Temp>> getAllOxy() async {
    // var uri = Uri.http("http://localhost:6000/offre/GetAllOffres/");

    final response = await http.get(TEMP_URL +"/GetAllOxy");
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
  static Future<List<Val>> getAllOxyV() async {
    // var uri = Uri.http("http://localhost:6000/offre/GetAllOffres/");

    final response = await http.get(TEMP_URL +"/Get");
    print("******************************");
    var data = jsonDecode(response.body);

    print(data);
    List _temp = [];

    for (var i in data) {
      print("******************************");
      print(i);
      _temp.add(i);
    }

    return Val.recipesFromSnapshot(_temp);
  }
}
