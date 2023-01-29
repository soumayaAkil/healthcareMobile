import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'login_page.dart';
import 'package:image_picker/image_picker.dart';

late File _image;

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState() {
    isPasswordVisible = true;
    isConfirmPasswordVisible = true;
    super.initState();
    // _onCameraClick();
  }

  bool visible = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numberController = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  Future<dynamic> userRegistration() async {
    setState(() {
      visible = true;
    });

    String name = nameController.text.trimRight().trimLeft();
    String email = emailController.text.trimRight().trimLeft();
    String password = passwordController.text.trimRight().trimLeft();
    String number = numberController.text.trimRight().trimLeft();

    var uri =""as Uri;
    //Uri.parse(Api.register);
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(multipartFile);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['number'] = number;

    var respond = await request.send();
    respond.stream.transform(utf8.decoder).listen((value) {
      print(value);

      if (value.toString() == '"User Registered Successfully"') {
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
                  "images/succe.gif",
                  width: 90,
                  height: 70,
                  fit: BoxFit.contain,
                ),
                Text('Successful ! ',
                    style: TextStyle(
                      color: Colors.blue,
                    )),
              ]),
              content: Text(
                value,
                style: TextStyle(
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: new Text("OK",
                      style: TextStyle(
                        color: Colors.blue,
                      )),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          visible = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
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
                value,
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
    });
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);

            PickedFile image =
            await _imagePicker.getImage(source: ImageSource.gallery);
            setState(() {
              image;
            });
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
            await _imagePicker.getImage(source: ImageSource.camera);
            setState(() {
              image;
            });
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        )
      ],
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 8.0, top: 32, right: 8, bottom: 8),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey.shade400,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 170,
                                  height: 170,
                                  child: _image == null
                                      ? Image.asset(
                                    'images/placeholder.jpg',
                                    fit: BoxFit.cover,
                                  )
                                      : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 80,
                              right: 0,
                              child: FloatingActionButton(
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(Icons.camera_alt),
                                  mini: true,
                                  onPressed: _onCameraClick),
                            )
                          ],
                        ),
                      ),

//

                      Container(
                        margin: EdgeInsets.only(top: 40),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: nameController,
                          autocorrect: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Name",
                              prefixIcon: Icon(Icons.person)),

                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: emailController,
                          autocorrect: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Email',
                              prefixIcon: Icon(Icons.email)),

                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: passwordController,
                          autocorrect: true,
                          obscureText: isPasswordVisible,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' ******** ',
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),

                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: confirmpassword,
                          autocorrect: true,
                          obscureText: isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              icon: Icon(isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),

                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: numberController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ' Number',
                            prefixIcon: Icon(Icons.call),
                          ),

                        ),
                      ),

                      // Divider(),
                      Visibility(
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: CircularProgressIndicator())),
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: 280,
                        height: 50,
                        child: ElevatedButton(
                          /*
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            */

                            onPressed: () {

                            },
                            child: Text(
                              'Register User',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ))));
  }
}
