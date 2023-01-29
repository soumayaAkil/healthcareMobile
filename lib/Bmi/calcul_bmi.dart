import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentindex = 0;
  String res="";
  String resc="";
  double h=0.0;
  double w=0.0;
 TextEditingController heightController = TextEditingController();
 TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calculer BMI"),
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
        IconButton(icon: Icon(Icons.add_alert), onPressed: () {

        })
      ],
    ),


        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("Man", Colors.black, 0,) ,
                    radioButton("Woman", Colors.pink, 1)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Saisir votre Hauteur en CM: ",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  key: Key("hauteur"),
                  controller: heightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Saisir votre Hauteur en CM: ",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Saisir votre Poids en Kg: ",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: weightController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Saisir votre Pois en Kg: ",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      )),
                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(left: 150),
                  width: 100,
                  height: 50.0,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                        print(heightController.value);
                        h=double.parse(heightController.value.text);
                        w=double.parse(weightController.value.text);


                        });
                        calculateBmi(h, w);
                      },
                      child: Text(
                        "Calculer ",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                    child: Text(
                  "votre BMI est :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                )),SizedBox(height: 50.0,),
                Container(
                    width: double.infinity,
                    child: Text(
                      "$res"   "      $resc",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
 void calculateBmi(double height, double weight){

 double result = weight / (height * height /10000);
 // convert the cm to metr /1000
 String BMI=result.toStringAsFixed(2);
setState(() {
  res=BMI;
  if(result < 18.5){ resc="Insuffisance pondérale";}
  if(result < 25 && result >18.5){ resc="Corpulence normale";}
  if(result < 30 && result >25){ resc="Surpoids";}
  if(result < 35 && result >30){ resc="Obésité modérée";}
  if(result < 40 && result >35){ resc="Obésité sévère";}
  if( result >40){ resc="Obésité morbide ou massive";}


});

 }
  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      height: 80.0,
      /* child:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
      ),
      */
      child: TextButton(
        onPressed: () {
          changeIndex(index);
        },
        child: Text(

          value,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        style: currentindex == index
            ? TextButton.styleFrom(
                primary: Colors.purple,
          //foregroundColor: Colors.pin k
              )
            : TextButton.styleFrom(
                primary: Colors.black,
              ),
      ),
    ));
  }
}
