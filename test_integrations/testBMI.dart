

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


import 'package:healthcare/main.dart'  as app;


void main(){

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(' BMI', () {
    var height = find.byKey(Key("hauteur"));
    var weight = find.byKey( Key("masse"));
    var submit = find.text("Calculer");

    testWidgets('calcul BMI', (tester)async {
      app.main();
      await tester.pumpAndSettle();


      await tester.enterText(height, "170");
      await tester.enterText(weight, "80");
      await tester.pumpAndSettle();

      await tester.pumpAndSettle();

      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();
      //expect(find.text("27.68"), findsOneWidget);
      expect(find.text("BMI"), findsOneWidget);
      await Future.delayed(Duration(seconds:3 ));

    });
  });




}



