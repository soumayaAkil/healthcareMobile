import 'dart:ui';
import 'package:flutter/material.dart';

import '../Bmi/calcul_bmi.dart';
import 'home_page_h.dart';
import 'login_page.dart';
import 'profile.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({ Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


bool isSignIn=true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromARGB(180, 250, 250, 250),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(31, 38, 135, 0.4),
              blurRadius: 8.0,
            )
          ],
          border: Border(
              right: BorderSide(
                color: Colors.white70,
              ))),
      child: Stack(
        children: [
          SizedBox(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple.withOpacity(0.0),
                        Colors.white.withOpacity(0.2),
                      ])),
                ),
              ),
            ),
          ),
          Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isSignIn
                        ? CircleAvatar(
                        radius: 40.0,
                        backgroundImage:
                            AssetImage("images/homme.png"),
                        backgroundColor: Colors.transparent)
                        : CircleAvatar(child: Icon(Icons.person)),
                    SizedBox(
                      width: 30.0,
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                           Text("samiberrajah@gmail.com"),
                        Text("sami berrajah"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "Acceuil",
                        style: TextStyle(color: Colors.purple, fontSize: 17),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Colors.purple,
                        size: 21,
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home_Page_h()));

                      },
                    ),
                    ListTile(
                      title: Text(
                        "Profile",
                        style: TextStyle(color: Colors.purple, fontSize: 17),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: Colors.purple,
                        size: 21,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profil()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Indice de masse corporelle",
                        style: TextStyle(color: Colors.purple, fontSize: 17),
                      ),
                      leading: Icon(
                        Icons.calculate_sharp,
                        color: Colors.purple,
                        size: 21,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BmiCalculator()));
                      },
                    ),



                    ListTile(
                      title: Text("Déconnexion",
                          style: TextStyle(color: Colors.purple, fontSize: 15)),
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.purple,
                        size: 21,
                      ),
                      onTap: () async {

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false,
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
