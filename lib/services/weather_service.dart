import 'dart:convert';

import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  String apiKey = "9437d7cbaf49482a9b741047251301";
  String baseUrl = "http://api.weatherapi.com/v1";
  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherModel weather = WeatherModel.fromJson(data);
    return weather;
  }
}
