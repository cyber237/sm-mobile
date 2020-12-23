import 'package:flutter/material.dart';
import 'timeTableBoard.dart';
import 'curved_back.dart';
import 'calenderBoard.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: new Stack(fit: StackFit.expand, children: [
          CurvedBack(),
          new ListView(
            padding: EdgeInsets.only(top: 100),
            children: [TimeTableBoard(), CalenderBoard()],
          ),
        ]));
  }
}
