class Weather {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final String icon;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15, // Convert Kelvin to Celsius
      weatherCondition: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
