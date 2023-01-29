import 'dart:convert';

import 'package:healthcare/models/freq.dart';
import 'package:healthcare/models/temp.dart';
import 'package:http/http.dart' as http;

import '../config.dart';


class FreqApi {

  static Future<List<Freq>> getAllFreq() async {
    // var uri = Uri.http("http://localhost:6000/offre/GetAllOffres/");

    final response = await http.get(FREQ_URL +"/GetAllFreq");
    print("******************************");
    var data = jsonDecode(response.body);

    print(data);
    List _temp = [];

    for (var i in data) {
      print("******************************");
      print(i);
      _temp.add(i);
    }

    return Freq.recipesFromSnapshot(_temp);
  }

}
