import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:schoolmanager/globalSettings.dart';
//import 'dart:convert';
import '../services/dataBackground.dart';

class StudentTimeTable extends StatefulWidget {
  StudentTimeTable({Key key}) : super(key: key);

  @override
  _StudentTimeTableState createState() => _StudentTimeTableState();
}

class _StudentTimeTableState extends State<StudentTimeTable> {
  final List data = mainData;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("${data.length}");
    return new MaterialApp(
        home: Scaffold(
      appBar: new AppBar(
        backgroundColor: MAINAPPBARCOLOR,
        centerTitle: true,
        title: new Text("TIME TABLE",
            style: new TextStyle(fontSize: 20, color: MAINHEADTEXTCOLOR)),
        leading: new IconButton(
          icon:
              new Icon(Icons.chevron_left, size: 30, color: MAINHEADTEXTCOLOR),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          new IconButton(
            icon: new Icon(Icons.list, size: 30, color: MAINHEADTEXTCOLOR),
            onPressed: () => null,
          ),
        ],
      ),
      body: new ListView(
        //TODO: change 0 to index
        children: [_weekSlides(), TimeTable(week: _arrangeData(data[index]))],
      ),
    ));
  }

  Widget _weekSlides() {
    BaseWeekObj weekData = _arrangeData(data[index]);
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        height: 60,
        child: new Swiper(
          loop: false,
          onIndexChanged: (ind) => setState(() => index = ind),
          control: SwiperControl(color: MAINHEADTEXTCOLOR.withOpacity(0.8)),
          itemCount: data.length,
          containerHeight: double.infinity,
          itemBuilder: (context, index) {
            return Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: new Text(weekData.weekName,
                    style: new TextStyle(
                        color: MAINHEADTEXTCOLOR,
                        fontSize: 22,
                        fontWeight: FontWeight.w500)));
          },
        ));
  }

  BaseWeekObj _arrangeData(Map<String, dynamic> weekData) {
    BaseWeekObj _arrangedWeekData = new BaseWeekObj();
    List daysweek = weekData["cells"];
    Map weekDates = weekData["week"];
    debugPrint("Num of days ${daysweek.length}");
    String firstDate =
        getDate(new DateTime.fromMillisecondsSinceEpoch(weekDates["firstDay"]));

    String lastDate =
        getDate(new DateTime.fromMillisecondsSinceEpoch(weekDates["lastDay"]));

    _arrangedWeekData.weekName = firstDate + " / " + lastDate;
    _arrangedWeekData.timeList = weekData["time"];
    _arrangedWeekData.mon = daysweek.elementAt(0);
    _arrangedWeekData.tue = daysweek.elementAt(1);
    _arrangedWeekData.wed = daysweek.elementAt(2);
    _arrangedWeekData.thu = daysweek.elementAt(3);
    _arrangedWeekData.fri = daysweek.elementAt(4);
    _arrangedWeekData.sat = daysweek.elementAt(5);
    _arrangedWeekData.sun = daysweek.elementAt(6);
    return _arrangedWeekData;
  }

  String getDate(DateTime date) {
    String newForm = (date.day.toString().length < 2
            ? "0" + date.day.toString()
            : date.day.toString()) +
        "-" +
        (date.month.toString().length < 2
            ? "0" + date.month.toString()
            : date.month.toString()) +
        "-" +
        date.year.toString();
    return newForm;
  }
}

class TimeTable extends StatefulWidget {
  TimeTable({Key key, this.week}) : super(key: key);
  final BaseWeekObj week;

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final List<String> _weekDays = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun"
  ];

  int _dayInfoCus = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: [
          _daySlider(context),
          _timeDataDisplay(_weekDays[_dayInfoCus])
        ],
      ),
    );
  }

  Widget _timeDataDisplay(String day) {
    final Map dataMap = {
      "mon": widget.week.mon,
      "tue": widget.week.tue,
      "wed": widget.week.wed,
      "thu": widget.week.thu,
      "fri": widget.week.fri,
      "sat": widget.week.sat,
      "sun": widget.week.sun,
    };
    List timeArray = widget.week.timeList;
    List<Widget> children = [];
    for (int i = 1; i <= dataMap[day].length; i++) {
      int firstindex = (i - 1) * 2;
      int lastindex = firstindex + 1;
      if (firstindex > (timeArray.length - 1) ||
          lastindex > (timeArray.length - 1)) {
        break;
      }
      debugPrint("$i");

      String headTime = timeArray[firstindex].toString() +
          " - " +
          timeArray[lastindex].toString();
      debugPrint(headTime);
      debugPrint("${dataMap[day][i - 1]}");
      try {
        children.add(DisplayBoard(head: headTime, data: dataMap[day][i - 1]));
      } catch (e) {}
    }
    return new Column(
      children: children,
    );
  }

  Widget _daySlider(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth,
        height: 70,
        child: new ListView(
          padding: EdgeInsets.symmetric(vertical: 10),
          scrollDirection: Axis.horizontal,
          children: _weekDays.map((day) => _dayPick(day)).toList(),
        ));
  }

  Widget _dayPick(String day) {
    int _indexOfDay = _weekDays.indexOf(day);
    bool active = _indexOfDay == _dayInfoCus;
    Color _buttColor = active ? MAINHEADTEXTCOLOR : null;
    Color _textColor = active ? Colors.white : MAINHEADTEXTCOLOR;
    return new GestureDetector(
      onTap: () {
        if (!(active)) {
          setState(() => _dayInfoCus = _indexOfDay);
        }
      },
      child: new Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 60,
          decoration: new BoxDecoration(
              border: Border.all(color: MAINHEADTEXTCOLOR),
              color: _buttColor,
              borderRadius: BorderRadius.circular(10)),
          child: new Text(day.toUpperCase(),
              style: new TextStyle(
                  fontSize: 15,
                  color: _textColor,
                  fontWeight: FontWeight.w600))),
    );
  }
}

class BaseWeekObj {
  String weekName;
  List timeList;
  List mon;
  List tue;
  List wed;
  List thu;
  List fri;
  List sat;
  List sun;
}

class DisplayBoard extends StatelessWidget {
  DisplayBoard({Key key, this.head, this.data}) : super(key: key);
  final String head;
  final Map data;
  final int _boxHeight = 50;
  final TextStyle _textStyle = TextStyle(
      fontSize: 19,
      color: Colors.blueGrey.shade700,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.9,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: new Card(
          elevation: 10,
          color: Colors.grey.shade50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: new Column(
            children: [
              _field(context, dataField: head, headText: true, first: true),
              _field(context, dataField: data["courseInfo"], headText: false),
              Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              _field(context, dataField: data["lecturerName"], headText: false),
              Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.grey.shade200,
                thickness: 2,
              ),
              _field(context,
                  dataField: data["venue"], headText: false, last: true)
            ],
          ),
        ));
  }

  Widget _field(BuildContext context,
      {String dataField,
      bool headText = false,
      bool last = false,
      bool first = false}) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.9,
        height: headText ? 60 : 50,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: headText ? MAINHEADTEXTCOLOR : Colors.grey.shade50,
          border: Border.all(
              color: headText ? MAINHEADTEXTCOLOR : Colors.grey.shade50),
          borderRadius: first
              ? new BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))
              : last
                  ? new BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : null,
        ),
        child: ListView(
            //itemExtent: 1,
            dragStartBehavior: DragStartBehavior.down,
            scrollDirection: Axis.horizontal,
            children: [
              new Container(
                width: _screenWidth * 0.9,
                height: headText ? 60 : 50,
                padding: EdgeInsets.symmetric(
                    vertical: headText ? 10 : 5, horizontal: 5),
                //width: double.infinity,
                alignment: Alignment.center,
                child: !headText
                    ? new Text(
                        dataField.isEmpty ? "" : dataField.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: _textStyle,
                        softWrap: false,
                      )
                    : new Text(
                        dataField.toUpperCase(),
                        textAlign: TextAlign.center,
                        softWrap: false,
                        style: new TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
              )
            ]));
  }
}
