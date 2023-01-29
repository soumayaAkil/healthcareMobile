import 'package:flutter/material.dart';

import '../main.dart';
import 'line_page_chart.dart';


class HomePageCourbe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("titre"), centerTitle: true),
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: PageView(
        children: [
          LineChartPage(),
        ],
      ),
    ),
  );
}