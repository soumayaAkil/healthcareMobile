import 'package:flutter/material.dart';

import 'Bmi/calcul_bmi.dart';
import 'acceuil.dart';
import 'charts/page.dart';
import 'courbs/hpage.dart';
import 'widget/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

debugShowCheckedModeBanner: false,
      home:
      Screen_page(),
      //HomePageCourbe(),
      //HomePage(),
    );
  }
}

