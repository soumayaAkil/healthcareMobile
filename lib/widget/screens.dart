import 'dart:async';

import 'package:flutter/material.dart';

import 'login_page.dart';


class Screen_page extends StatefulWidget {
  @override
  _Screen_pageState createState() => _Screen_pageState();
}

class _Screen_pageState extends State<Screen_page>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, Login);
  }

  void Login() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 6));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.pink],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: Stack(fit: StackFit.expand, children: <Widget>[
            new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 200.0),
                      child: new Image.asset(
                        "images/h2.gif",
                        height: 160.0,
                        fit: BoxFit.contain,
                      )),
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        new Image.asset(
                          'images/h4.webp',
                          width: animation.value * 60,
                          height: animation.value * 60,
                        ),Text('Healthcare',style:TextStyle(fontSize : 23,color: Colors.white),),
                      ])
                ]),
          ]),
        ));

  }
}
