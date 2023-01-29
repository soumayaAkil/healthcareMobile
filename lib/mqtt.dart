
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'widget/home_page_h.dart';
class mqttclass extends StatefulWidget {
  const mqttclass({Key? key}) : super(key: key);

  @override
  State<mqttclass> createState() => _mqttclassState();
}

class _mqttclassState extends State<mqttclass> {
  late String topic;
  @override
  void initState() {

    super.initState();
  }

  Future showmsg(final ch) async {

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
            Text(' valeur de topic ! ',
                style: TextStyle(
                  color: Colors.purple,
                )),
          ]),
          content: Text(
            "$ch",
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

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_Page_h()));

              },
            ),
          ],
        );
      },
    );

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     body:SingleChildScrollView(
     child:Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(150.0),
                bottomRight: const Radius.circular(150.0),
              ),
              child: Image.asset('images/h9.jpg',
              ),
            ),
            SizedBox(height:60),
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
                textInputAction: TextInputAction.next,
                onSubmitted: (input) {
            topic=input;
                },
                autocorrect: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: ' Topic',
                    prefixIcon: Icon(Icons.message_sharp)))),
            Container(
              margin: EdgeInsets.only(top: 80),
              width: 320,
              height: 40,
              child: TextButton(

                  onPressed: () {
                    setState(() {
                      published(topic);
                    });
                  },

                  child: Text(
                    'ADD',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold),
                  )),
            ),
   ] ),),
    );
  }

  void published(String top) {

    connect( top);
  }

  Future<MqttServerClient> connect(String top) async {

    MqttServerClient client =
    MqttServerClient.withPort("broker.hivemq.com", 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;


    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    print('EXAMPLE::Subscribing to the bidTv topic');
     client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      showmsg(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');

    });
    return client;
  }
}
void onConnected() {
  print('Connnnnnnnnnnnnected');
}