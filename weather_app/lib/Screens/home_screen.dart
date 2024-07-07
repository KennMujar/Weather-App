import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text;
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(city);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherDetailsScreen(),
                    ),
                  );
                }
              },
              child: Text('Search'),
            ),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                if (weatherProvider.isLoading) {
                  return CircularProgressIndicator();
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
