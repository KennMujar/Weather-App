import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'ef8a93f3d260a9dfc1e4db477a516e28';
  static const String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
