

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/freq.dart';



//import 'package:weather_icons/weather_icons.dart';



class Frequence extends StatefulWidget {

  final List<Freq> Freqs ;
  const Frequence({required this.Freqs});
  _Frequence createState() => _Frequence();
}

class _Frequence extends State<Frequence> {
  late bool _isLoading=true;




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Frequence"),
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
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body:  Center(
            child: SingleChildScrollView(
                child: Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 80,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Frequence : " ,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.blueGrey[100]),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset("images/f.webp",
                                        width: 100, height: 100, fit: BoxFit.cover),
                                  ),
                                ])),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 250,
                            height: 150,
                            child:(

                                ListView(
                                    children: [
                                      for (int i = 0; i < widget.Freqs.length; i++)
                                        Card(
                                            child: ListTile(
                                              title: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.calendar_today,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),Expanded(child:
                                                    Text(""+widget.Freqs[i].date_add_freq),
                                                    ),SizedBox(
                                                      width: 7,
                                                    ),
                                                    Icon(
                                                      Icons.timelapse_outlined,
                                                      size: 15,
                                                    ),
                                                  ]),
                                              subtitle: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: <Widget>[

                                                    Text(
                                                      ""+widget.Freqs[i].val_freq+" bpm",
                                                      style: TextStyle(fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                  ]),
                                              onTap: () {

                                                Fluttertoast.showToast(
                                                    msg: " Frequence : "+widget.Freqs[i].val_freq ,

                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.teal,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              },
                                            ))]
                                ) )



                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          width: 300,
                          height: 300,
                          child: FutureBuilder(

                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                if (_isLoading == true)
                                  return new charts.PieChart(dataList(widget.Freqs),
                                      animate: true,
                                      defaultRenderer: new charts.ArcRendererConfig(
                                          arcRendererDecorators: [
                                            new charts.ArcLabelDecorator()
                                          ])
                                    /*defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 20,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator()
                            ]),*/
                                    //behaviors: [new charts.DatumLegend(position: charts.BehaviorPosition.bottom,outsideJustification: charts.OutsideJustification.middleDrawArea,desiredMaxColumns: 2,desiredMaxRows: 10
                                    //) ]
                                  );
                                else
                                  return Center(child: CircularProgressIndicator());
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          width: 300,
                          height: 300,
                          child: FutureBuilder(
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                if (_isLoading == true)
                                  return new charts.TimeSeriesChart(
                                    _createSampleData(
                                      widget.Freqs,
                                    ),
                                    animate: true,
                                    defaultRenderer: charts.LineRendererConfig(
                                        includeArea: true,
                                        areaOpacity: 0.8,
                                        stacked: false),
                                    dateTimeFactory:
                                    const charts.LocalDateTimeFactory(),
                                    domainAxis: charts.DateTimeAxisSpec(
                                      tickFormatterSpec:
                                      charts.AutoDateTimeTickFormatterSpec(
                                        day: charts.TimeFormatterSpec(
                                          format: 'dd',
                                          transitionFormat: 'dd MMM',
                                        ),
                                      ),
                                    ),
                                    behaviors: [
                                      new charts.PanAndZoomBehavior(),
                                      new charts.ChartTitle('Courbe Temperature',
                                          //subTitle: 'Top sub-title text',
                                          behaviorPosition:
                                          charts.BehaviorPosition.top,
                                          titleOutsideJustification:
                                          charts.OutsideJustification.start,
                                          innerPadding: 18),
                                      new charts.ChartTitle('Date',
                                          behaviorPosition:
                                          charts.BehaviorPosition.bottom,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middleDrawArea),
                                      new charts.ChartTitle('Temperature ',
                                          behaviorPosition:
                                          charts.BehaviorPosition.start,
                                          titleOutsideJustification: charts
                                              .OutsideJustification.middleDrawArea),
                                    ],
                                  );
                                else
                                  return Center(child: CircularProgressIndicator());
                              }),
                        )
                      ],
                    )))));
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(
      List<Freq> apiData) {
    List<TimeSeriesSales> listt = <TimeSeriesSales>[];
    for (int i = 0; i < apiData.length; i++)
      listt.add(new TimeSeriesSales(
          DateTime.parse(apiData[i].date_add_freq), double.parse(apiData[i].val_freq)));
    print(listt[1].temp);
    return [
      new charts.Series<TimeSeriesSales, DateTime>(

          id: 'Temperature',
          colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.temp,
          measureFn: (TimeSeriesSales sales, _) => sales.dd,

          //data: listt,
          data: listt
        //labelAccessorFn: (LinearSales row, _) => '${row.temperature}: ${row.date}',
      ),
    ];
  }

  static List<charts.Series<LinearSales, String>> dataList(
      List<Freq> apiDatat) {
    List<LinearSales> list = <LinearSales>[];

    for (int i = 0; i < apiDatat.length; i++)
    {
      list.add(new LinearSales(i+1,double.parse( apiDatat[i].val_freq)));
    }
    return [
      new charts.Series<LinearSales, String>(
        id: 'Temperature',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.temperature.toString(),
        measureFn: (LinearSales sales, _) => sales.data,
        data: list,
        labelAccessorFn: (LinearSales row, _) =>
        'val ${row.temperature}:   ${row.data}',
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime temp;
  final double dd;

  TimeSeriesSales(this.temp, this.dd);
}


class LinearSales {
  int temperature;
  double data;
  LinearSales(this.temperature, this.data);
}

