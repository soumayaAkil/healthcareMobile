import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/freq.api.dart';
import '../models/freq.dart';
import '../models/oxy.api.dart';
import '../models/oxy.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../models/oxygene.api.dart';
import '../models/oxygene.dart';
import '../models/temp.api.dart';
import '../models/temp.dart';
import 'frequence.dart';
import 'mydrawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../mqtt.dart';
import 'oxygene.dart';
import 'temperature.dart';

class Home_Page_h extends StatefulWidget {
  Home_Page_h();

  @override
  _Home_Page createState() => _Home_Page();
}

class _Home_Page extends State<Home_Page_h> {
  var matricule;
  var name;
  late List<Temp> _list_Temps;
  late List<Freq> _list_Freqs;
  late List<Oxy> _list_Oxys;
  bool isSignIn = false;
  //List<Val>? _vals ;
  late String actuel_temp = "37";
  late String actuel_dist = "0";
  late String actuel_press = "100";
  late String actuel_oxy = "100";
  @override
  void initState() {
    matricule = "";
    getRecipes();
    super.initState();
    subsciber_temp();
    subsciber_dist();
    subsciber_press();
    subsciber_oxy();


    setState(() {
      getRecipes();
      getRecipesOxy();
      getRecipesFreq();
    });

  }
  Future<void> getRecipes() async {
    print("gggggggggggggggggg");
    _list_Temps = await TempApi.getAllTemp();
  }
  Future<void> getRecipesOxy() async {

    _list_Oxys = await OxyApi.getAllOxy();
  }
  Future<void> getRecipesFreq() async {

    _list_Freqs = await FreqApi.getAllFreq();
  }
  Future<MqttServerClient> subsciber_temp() async {
    MqttServerClient client =
        MqttServerClient.withPort('broker.hivemq.com', 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    print('EXAMPLE::Subscribing to the temperature topic');
    const topic = 'hc/app/temp'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setState(() {
        actuel_temp = pt;
      });
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
/*
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
*/
    return client;
  }

  Future<MqttServerClient> subsciber_press() async {
    MqttServerClient client =
    MqttServerClient.withPort('broker.hivemq.com', 'flutter_clie', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    print('EXAMPLE::Subscribing to the temperature topic');
    const topic = 'hc/app/press'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setState(() {
        actuel_press = pt;
      });
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
/*
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
*/
    return client;
  }
  Future<MqttServerClient> subsciber_dist() async {
    MqttServerClient client_dist =
    MqttServerClient.withPort('broker.hivemq.com', 'flutter_client_dist', 1883);
    client_dist.logging(on: true);
    client_dist.onConnected = onConnected;

    try {
      await client_dist.connect();
    } catch (e) {
      print('Exception: $e');
      client_dist.disconnect();
    }

    print('EXAMPLE::Subscribing to the temperature topic');
    const topic = 'hc/app/dist'; // Not a wildcard topic
    client_dist.subscribe(topic, MqttQos.atMostOnce);
    client_dist.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setState(() {
        actuel_dist = pt;
      });
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    return client_dist;
  }
  Future<MqttServerClient> subsciber_oxy() async {
    MqttServerClient client =
    MqttServerClient.withPort('broker.hivemq.com', 'flutter_client_oxy', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    print('EXAMPLE::Subscribing to the temperature topic');
    const topic = 'hc/app/oxy'; // Not a wildcard topic
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      setState(() {
        actuel_oxy = pt;
      });
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
/*
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);
    /// Publish it
    print('EXAMPLE::Publishing our topic');
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
*/
    return client;
  }
// connection succeeded
  void onConnected() {
    print('Connnnnnnnnnnnnected');
  }

  Future<void> getRecipesv() async {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Acceuil"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          elevation: 20.0,
          shadowColor: Colors.purple,
          backgroundColor: Colors.purple,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add_alert),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mqttclass()));
                })
          ],
        ),
        drawerScrimColor: Colors.transparent,
        drawer: MyDrawer(
          key: Key("value"),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 80.0,
              width: double.infinity,
              child: Carousel(
                images: [
                  Image.asset('images/h3.jfif', fit: BoxFit.contain),
                  Image.asset('images/h6.jpg', fit: BoxFit.contain),
                  Image.asset('images/c2.jpg', fit: BoxFit.contain),
                ],
                dotSize: 5,
                dotBgColor: Colors.white.withOpacity(0.5),
                overlayShadow: true,
                dotIncreasedColor: Colors.purple,
              ),
            ),

            Container(
              height: 140,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10, crossAxisCount: 3),
                children: <Widget>[
                  InkWell(
                    child: GridTile(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("images/shelter/tempp.png",
                            width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      footer: Container(
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          "Temperature",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Temperature(Temps:_list_Temps)));
                    },
                  ),
                  InkWell(
                      child: GridTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset("images/f.webp",
                              width: 100, height: 100, fit: BoxFit.cover),
                        ),
                        footer: Container(
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            "Fréquence ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {


                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Frequence(Freqs:_list_Freqs)));

                      }),
                  InkWell(
                      child: GridTile(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset("images/o.jpg",
                              width: 100, height: 100, fit: BoxFit.contain),
                        ),
                        footer: Container(
                          // margin: EdgeInsets.only(top:20),
                          width: 45,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            "Oxygéne",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Oxygene(Oxys:_list_Oxys)));

                        /*
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dust()));
                          */
                      }),
                ],
              ),
            ),

            //
            Center(
              child: SingleChildScrollView(
                  child:
                  /* Form(
    child: Column( mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        */
                      Container(
                height: 400,
                child: Column(children: <Widget>[
                 /* Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, i) {
                            return SizedBox(
                              width: 130,
                              height: 180,
                              child: SfRadialGauge(
                                  title: GaugeTitle(
                                      text: "Temperature",
                                      textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      )),
                                  enableLoadingAnimation: true,
                                  animationDuration: 400,
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: -20,
                                        maximum: 60,
                                        ranges: <GaugeRange>[
                                          GaugeRange(
                                              startValue: -20,
                                              endValue: 5,
                                              color: Colors.yellow,
                                              startWidth: 10,
                                              endWidth: 10),
                                          GaugeRange(
                                              startValue: 5,
                                              endValue: 35,
                                              color: Colors.orange,
                                              startWidth: 10,
                                              endWidth: 10),
                                          GaugeRange(
                                              startValue: 35,
                                              endValue: 60,
                                              color: Colors.red,
                                              startWidth: 10,
                                              endWidth: 10),
                                        ],
                                        pointers: <GaugePointer>[
                                          NeedlePointer(
                                            value: 38.0,
                                          )
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Container(
                                                  child: Text(
                                                      "${actuel_temp} °C",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              angle: 90,
                                              positionFactor: 0.5),
                                        ])
                                  ]),
                            );
                          })),
                  */
                  Container(
                      height: 200,
                      child: new Row(children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  return SizedBox(
                                    width: 250,
                                    height: 180,
                                    child: SfRadialGauge(
                                        title: GaugeTitle(
                                            text: "Temperature",
                                            textStyle: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 20,
                                            )),
                                        enableLoadingAnimation: true,
                                        animationDuration: 4500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                              minimum: 37,
                                              maximum: 42,
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                    startValue: 0,
                                                    endValue: 38.5,
                                                    color: Colors.yellow,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 38.5,
                                                    endValue: 40,
                                                    color: Colors.orange,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 40,
                                                    endValue: 42,
                                                    color: Colors.red,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                              ],
                                              pointers: <GaugePointer>[
                                                NeedlePointer(
                                                  value:double.parse(actuel_temp),
                                                )
                                              ],
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    widget: Container(
                                                        child: Text(
                                                            "\n \n ${actuel_temp} °C",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    angle: 90,
                                                    positionFactor: 0.5),
                                              ])
                                        ]),
                                  );
                                })),
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  return SizedBox(
                                    width: 250,
                                    height: 180,
                                    child: SfRadialGauge(
                                        title: GaugeTitle(
                                            text: "Distance",
                                            textStyle: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 20,
                                            )),
                                        enableLoadingAnimation: true,
                                        animationDuration: 4500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                              minimum: 0,
                                              maximum: 10000,
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                    startValue: 0,
                                                    endValue: 1000,
                                                    color: Colors.yellow,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 1000,
                                                    endValue: 9000,
                                                    color: Colors.orange,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 9000,
                                                    endValue: 10000,
                                                    color: Colors.red,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                              ],
                                              pointers: <GaugePointer>[
                                                NeedlePointer(
                                                  value: double.parse(actuel_dist),
                                                )
                                              ],
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    widget: Container(
                                                        child: Text(
                                                            "\n \n ${actuel_dist} steps",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    angle: 90,
                                                    positionFactor: 0.5),
                                              ])
                                        ]),
                                  );
                                }))
                      ])),
                  Container(
                      height: 200,
                      child: new Row(children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  return SizedBox(
                                    width: 250,
                                    height: 180,
                                    child: SfRadialGauge(
                                        title: GaugeTitle(
                                            text: "Pression",
                                            textStyle: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 20,
                                            )),
                                        enableLoadingAnimation: true,
                                        animationDuration: 4500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                              minimum: 60,
                                              maximum: 250,
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                    startValue: 60,
                                                    endValue: 100,
                                                    color: Colors.yellow,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 100,
                                                    endValue: 150,
                                                    color: Colors.orange,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 150,
                                                    endValue: 250,
                                                    color: Colors.red,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                              ],
                                              pointers: <GaugePointer>[
                                                NeedlePointer(
                                                  value: double.parse(actuel_press),
                                                )
                                              ],
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    widget: Container(
                                                        child: Text(
                                                            "  \n \n${actuel_press} cmHg",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.teal,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    angle: 90,
                                                    positionFactor: 0.5),
                                              ])
                                        ]),
                                  );
                                })),
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, i) {
                                  return SizedBox(
                                    width: 250,
                                    height: 180,
                                    child: SfRadialGauge(
                                        title: GaugeTitle(
                                            text: "Oxygene",
                                            textStyle: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 20,
                                            )),
                                        enableLoadingAnimation: true,
                                        animationDuration: 4500,
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                              minimum: 0,
                                              maximum: 100,
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                    startValue: 0,
                                                    endValue: 80,
                                                    color: Colors.red,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 80,
                                                    endValue: 90,
                                                    color: Colors.orange,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 90,
                                                    endValue: 100,
                                                    color: Colors.yellow,
                                                    startWidth: 10,
                                                    endWidth: 10),
                                              ],
                                              pointers: <GaugePointer>[
                                                NeedlePointer(
                                                  value: double.parse(actuel_oxy),
                                                )
                                              ],
                                              annotations: <GaugeAnnotation>[
                                                GaugeAnnotation(
                                                    widget: Container(
                                                        child: Text(
                                                            "\n \n ${actuel_oxy} steps",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    angle: 90,
                                                    positionFactor: 0.5),
                                              ])
                                        ]),
                                  );
                                }))
                      ])),
                ]),
              ) /*
      ]),),
                                   */

                  ),
            ),
          ]),
        ),
      ),
    );
  }
}
