import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Models/weathers_model.dart';

class Apihalper {
  Apihalper._();

  static Apihalper apihalper = Apihalper._();

  Future<Weather?> getWeatherData({required String city}) async {
    log("API Method is called...");
    Uri url = Uri.parse(
      "https://api.weatherapi.com/v1/forecast.json?key=7c45c33977d64f5a89783251232305&q=$city&aqi=no",
    );

    http.Response res = await http.get(url);

    if (res.statusCode == 200) {
      Map<String, dynamic> allWeatherData = jsonDecode(res.body);
      Weather weather = Weather.formMap(data: allWeatherData);
      return weather;
    }
    return null;
  }
}
