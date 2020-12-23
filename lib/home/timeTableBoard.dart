import 'package:flutter/material.dart';
import 'package:schoolmanager/home/homeGlobalsettings.dart';
import '../globalSettings.dart';
import '../timeTable/receiverPage.dart';

class TimeTableBoard extends StatelessWidget {
  const TimeTableBoard({Key key}) : super(key: key);
  static final Map<String, String> _testData = {
    "Course": "",
    "Hall": "",
    "Lecturer": ""
  };
  static final List<Map<String, String>> _testList = [
    _testData,
    _testData,
    _testData,
    _testData
  ];
  final Widget _horizontalHeadDivider = const Divider(
    indent: 40,
    endIndent: 40,
    thickness: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _screenWidth > 400 ? _screenWidth * 0.8 : _screenWidth * 0.9,
      child: new InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentTimeTable()),
        ),
        child: new Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 5,
          child: new Column(
            children: [
              _timeTableHead(),
              _horizontalHeadDivider,
              _subHead(),
              _horizontalHeadDivider,
              _date(),
              _dataBox(context: context, dataList: _testList)
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeTableHead() {
    return new Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: new Text(
        "TIME TABLE",
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w800,
            color: MAINHEADTEXTCOLOR.withOpacity(0.8),
            letterSpacing: 1.3,
            height: 1.5),
      ),
    );
  }

  Widget _subHead() {
    return new Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: new Text(
        "Current Week",
        textAlign: TextAlign.left,
        style: new TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: MAINHEADTEXTCOLOR.withOpacity(0.8),
            letterSpacing: 1.2,
            height: 1.5),
      ),
    );
  }

  Widget _date() {
    final TextStyle _dayStyle = new TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: MAINHEADTEXTCOLOR.withOpacity(0.5),
        letterSpacing: 1.2,
        height: 1.2);
    final TextStyle _dateStyle = new TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: MAINHEADTEXTCOLOR.withOpacity(0.6),
        letterSpacing: 1.2,
        height: 1.2);
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new Text(
            "Today",
            style: _dayStyle,
          ),
          new Text(
            "00/00/0000",
            style: _dateStyle,
          )
        ],
      ),
    );
  }

  Widget _dataColumn(
      {BuildContext context, Map<String, String> data, int index}) {
    final double _boxWidth = MediaQuery.of(context).size.width * cardwidthRatio;

    String _time;

    switch (index) {
      case 1:
        _time = "  08:00-09:50";
        break;
      case 2:
        _time = "  09:50-12:00";
        break;
      case 3:
        _time = "  01:00-02:50";
        break;
      case 4:
        _time = "  03:10-05:00";
        break;
    }
    List<Widget> _children = [
      new Text(
        _time,
        style: new TextStyle(
            fontSize: _boxWidth > 280 ? 13 : 11,
            fontWeight: FontWeight.w900,
            color: Colors.grey.shade600),
      ),
    ];
    _children.addAll(
        data.keys.map((key) => Field(data: data[key], data_key: key)).toList());

    return new Container(
      width: _boxWidth * 0.23,
      height: 140,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _children),
    );
  }

  Widget _dataBox({BuildContext context, List<Map<String, String>> dataList}) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: dataList
            .asMap()
            .map(
              (index, value) => MapEntry(index,
                  _dataColumn(context: context, data: value, index: index + 1)),
            )
            .values
            .toList(),
      ),
    );
  }
}

class Field extends StatefulWidget {
  Field({Key key, this.data, this.data_key}) : super(key: key);
  final String data;
  final String data_key;

  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final Color _onHover = Colors.grey.shade200;
  Color _boxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final double _boxWidth = MediaQuery.of(context).size.width * cardwidthRatio;
    return new InkWell(
        focusColor: _onHover,
        highlightColor: _onHover,
        splashColor: _onHover,
        hoverColor: _onHover,
        child: new Container(
            width: _boxWidth * 0.23,
            color: _boxColor,
            height: 30,
            child: new ListView(
                padding: EdgeInsets.symmetric(vertical: 7),
                scrollDirection: Axis.horizontal,
                children: [
                  new Text(
                    widget.data.isEmpty ? widget.data_key : widget.data,
                    style: new TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500),
                  )
                ])));
  }
}
