import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/weather_model.dart';
import '../Services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;
  String? _lastSearchedCity;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get lastSearchedCity => _lastSearchedCity;

  final WeatherService _weatherService = WeatherService();

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
      _lastSearchedCity = city;
      _saveLastSearchedCity(city);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  Future<void> _loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    _lastSearchedCity = prefs.getString('lastSearchedCity');
    if (_lastSearchedCity != null) {
      fetchWeather(_lastSearchedCity!);
    }
  }
}
