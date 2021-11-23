import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String sharedPreferencesKey = "date";
String API_KEY = "mRRxgpKPMPZhpcrUV9e5fKNrco63Jdn4PLtUVTnd";
String API_URL = "https://api.nasa.gov/planetary/apod?api_key=";

Dio dio = new Dio();

Future<String> getImageUrl(String date) async {
  String url = API_URL + API_KEY + "&date=" + date;
  Future<Response> response = dio.get(url);
  return response.then((response) => response.data["url"]);
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
void setDateSharedPreferences(String value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setString(sharedPreferencesKey, value);
}

Future<String?> getDateSharedPreferences() async {
  final SharedPreferences prefs = await _prefs;
  return prefs.getString(sharedPreferencesKey);
}

Map colorMap = {
  "Monday": Colors.blue,
  "Tuesday": Colors.black,
  "Wednesday": Colors.white,
  "Thursday": Colors.green,
  "Friday": Colors.red,
  "Saturday": Colors.pink,
  "Sunday": Colors.yellow,
  "Error": Colors.grey
};
