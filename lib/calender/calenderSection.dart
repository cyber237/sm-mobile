import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CalenderSection extends StatefulWidget {
  CalenderSection({Key key}) : super(key: key);

  @override
  _CalenderSectionState createState() => _CalenderSectionState();
}

class _CalenderSectionState extends State<CalenderSection> {
  @override
  List<String> _months = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "decemder"
  ];

  final SwiperController _monthSwipeControl = new SwiperController();
  int _currentMonth_index = 0;
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: new Column(
        children: [
          //new Expanded(child: ,flex: 1,)
        ],
      ),
    );
  }

  Widget _head() {
    return new Container(
      child: new Row(
        children: [
          new Text(_months[_currentMonth_index].substring(0, 2).toUpperCase(),
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade700)),
          new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new Swiper(
                itemCount: _months.length,
                index: _currentMonth_index,
                controller: _monthSwipeControl,
                containerHeight: double.infinity,
                containerWidth: 100,
              ))
        ],
      ),
    );
  }
}
