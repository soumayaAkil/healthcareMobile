import 'package:flutter/material.dart';
import 'dart:convert';

import '../models/oxy.api.dart';
import '../models/oxy.dart';
import '../models/temp.api.dart';
import 'home_page_h.dart';
import 'register_pages.dart';


// ignore: camel_case_types

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  @override
  void initState() {
    _obscureText = true;
    _emailFocus = FocusNode();
    _pwFocus = FocusNode();


    super.initState();
  }

  bool visible = false;
  late FocusNode _emailFocus, _pwFocus;
  bool _obscureText = true;
  late String _password;
  late String _email;

  var mytoken;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  List<Val>? _vals ;

  Future userLogin() async {
    setState(() {
      visible = true;
    });
    String email = emailController.text.trimRight().trimLeft();
    String password = passwordController.text.trimRight().trimLeft();
    var formdata = _formkey.currentState;
/*
    Future<void> getRecipesv() async {
      print("ggggggggggggggg");
      _vals = await TempApi.getAllTempV();
      print(_vals![0]);
    }
    */
      var data = {'email': email, 'password': password, 'token': mytoken};


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            title: Row(children: [
              Image.asset(
                "images/succe.gif",
                width: 90,
                height: 70,
                fit: BoxFit.contain,
              ),
              Text('Succès ! ',
                  style: TextStyle(
                    color: Colors.purple,
                  )),
            ]),
            content: Text(
              "bienvenue Healthcare app ",
              style: TextStyle(
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("OK",
                    style: TextStyle(
                      color: Colors.white,
                    )),
          style: ElevatedButton.styleFrom(primary: Colors.purple),
                onPressed: () {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home_Page_h()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    /* else {
      setState(() {
        visible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            title: Row(children: [
              Image.asset(
                "images/error.gif",
                width: 90,
                height: 60,
                fit: BoxFit.contain,
              ),
              Text(
                'Oops !!!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.redAccent,
                ),
              ),
            ]),
            content: new Text(
              "Invalid Username or Password Please Try Again",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("Close",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
     */
  }


  void _validate() {

  }

/*
  bool isValidEmail() {
    if ((_email == null) || (_email.length == 0)) {
      return true;
    }
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }
  */


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[

            ClipRRect(
            borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(150.0),
          bottomRight: const Radius.circular(150.0),
        ),
      child: Image.asset('images/h2.gif',
      ),
    ),
    SizedBox(height:10),
            Form(

              child: Column(children: <Widget>[

                Container(
                    margin: EdgeInsets.only(top: 40),
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black12,
                    ),
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(

                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (input) {

                        },
                        onTap: _validate,
                        autocorrect: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' Email',
                            prefixIcon: Icon(Icons.email)))),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black12,
                    ),
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(

                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {},
                        onTap: _validate,
                        decoration: InputDecoration(

                            suffixIcon: IconButton(
                              icon: Icon(

                                Icons.visibility_off,
                                color: Theme
                                    .of(context)
                                    .primaryColorDark,
                              ), onPressed: () {},
                            ),
                            border: InputBorder.none,
                            hintText: ' ********',
                            prefixIcon: Icon(Icons.vpn_key)))),
               /* Visibility(

                    child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: CircularProgressIndicator())),
                */
                Container(
                  margin: EdgeInsets.only(top: 60),
                  width: 320,
                  height: 40,
                  child: TextButton(

                      onPressed: () {
                        userLogin();
                      },

                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 16.0),
                  child: InkResponse(
                      onTap: () {

                      },
                      child: Text(
                        "Forgot Password? Troubleshoot",
                        style: TextStyle(color: Colors.black45, fontSize: 13),
                      )),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have an account ? ",
                        ),
                        InkWell(
                          splashColor: Colors.green.withOpacity(0.5),
                          onTap: () {

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => RegPage()));

                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ))
              ]),
            )])
        ),
    );
  }

}