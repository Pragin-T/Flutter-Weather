import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_proj/models/weather_model.dart';

class WeatherService {
  final String apiKey;
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

  Future<Weather> fetchWeatherByCity(String city) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$city&appid=$apiKey&units=metric'));

    // Check if the request was successful
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      // Throw a specific error if the city is not found or another error occurs
      final errorBody = json.decode(response.body);
      throw Exception(errorBody['message'] ?? 'Failed to load weather data');
    }
  }

  Future<Weather> fetchWeatherByCoords(double lat, double lon) async {
    final response = await http.get(
        Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather for your location.');
    }
  }
}
