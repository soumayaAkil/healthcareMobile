import 'dart:convert';

import 'package:healthcare/models/temp.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'oxygene.dart';


class OxyApi {

  static Future<List<Oxy>> getAllOxy() async {
    // var uri = Uri.http("http://localhost:6000/offre/GetAllOffres/");

    final response = await http.get(OXY_URL +"/GetAllOxy");
    print("******************************");
    var data = jsonDecode(response.body);

    print(data);
    List _temp = [];

    for (var i in data) {
      print("******************************");
      print(i);
      _temp.add(i);
    }

    return Oxy.recipesFromSnapshot(_temp);
  }

}
