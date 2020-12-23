import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List mainData;

Future<void> getData() async {
  http.Response response = await http.get(
      "http://192.168.0.100:45000/getTT/?accountType=student&platform=mobile&level=SWE_L2&_id=stud-8kckhkwr6ru",
      headers: {'Content-Type': 'application/json;charset=utf-8'});
  mainData = await json.decode(response.body);
  debugPrint("$mainData");
}
