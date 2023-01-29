
import 'package:flutter/material.dart';

class cardtemp extends StatefulWidget {
  const cardtemp({Key? key}) : super(key: key);

  @override
  State<cardtemp> createState() => _cardtempState();
}

class _cardtempState extends State<cardtemp> {
  final colorwhite = Colors.white;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '  Heart Rate',
              style: TextStyle(color: colorwhite, fontSize: 16),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Color.fromRGBO(255, 255, 255, 0.38)),
              child: Icon(
                Icons.favorite,
                color: colorwhite,
                size: 30,
              ),
            )
          ],
        )
        ,Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left:10,bottom: 20),
            child: Text('144 bpm'
              ,style: TextStyle(
                  fontSize: 27,
                  color: colorwhite),
            )),
        Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right:10),
            child: Column(
              children: [
                Text('Temperature'
                  ,style: TextStyle(
                      fontSize: 18,
                      color: colorwhite),
                ),
                Text('37-40'
                  ,style: TextStyle(
                      fontSize: 18,
                      color: colorwhite),
                ),
              ],
            ))

      ],
    );
  }
}
