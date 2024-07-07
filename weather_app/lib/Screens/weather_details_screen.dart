import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (weatherProvider.weather != null) {
                weatherProvider.fetchWeather(weatherProvider.weather!.cityName);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weatherProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : weatherProvider.errorMessage != null
                ? Center(child: Text(weatherProvider.errorMessage!))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City: ${weatherProvider.weather!.cityName}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Temperature: ${weatherProvider.weather!.temperature.toStringAsFixed(1)}°C',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Condition: ${weatherProvider.weather!.weatherCondition}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Image.network(
                        'http://openweathermap.org/img/wn/${weatherProvider.weather!.icon}.png',
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humidity: ${weatherProvider.weather!.humidity}%',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Wind Speed: ${weatherProvider.weather!.windSpeed} m/s',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
      ),
    );
  }
}
