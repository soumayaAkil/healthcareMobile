
import 'package:flutter/material.dart';

import '../main.dart';
import 'chartpage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("ddd"), centerTitle: true),
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: PageView(
        children: [
          PieChartPage(),

        ],
      ),
    ),
  );
}