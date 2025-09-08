import 'package:flutter/material.dart';
import 'package:flutter_proj/models/weather_model.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  // This function now uses the correct .gif extension for all asset paths
  String _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/images/Sunny.gif'; // Fixed: .jpg -> .gif
      case 'clouds':
        return 'assets/images/Clouds.gif'; // Fixed: .jpg -> .gif
      case 'rain':
      case 'drizzle':
        return 'assets/images/Rain.gif'; // Fixed: .jpg -> .gif
      case 'thunderstorm':
        return 'assets-images/Thunder.gif'; // Fixed: .jpg -> .gif
      case 'snow':
        return 'assets/images/Snow.gif'; // Fixed: .jpg -> .gif
      case 'atmosphere':
      case 'squall':
      case 'tornado':
        return 'assets/images/Wind.gif'; // Fixed: .jpg -> .gif
      default:
        return 'assets/images/Clouds.gif'; // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Image.asset(
            _getWeatherIcon(weather.condition),
            height: 150,
            gaplessPlayback: true,
          ),
          const SizedBox(height: 20),
          Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w200),
          ),
          Text(
            weather.description,
            style: const TextStyle(fontSize: 24, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildExtraDetail('Humidity', '${weather.humidity}%'),
              _buildExtraDetail('Wind Speed', '${weather.windSpeed} m/s'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExtraDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
