import 'package:flutter/material.dart';
import 'package:flutter_proj/api/weather_service.dart';
import 'package:flutter_proj/models/weather_model.dart';
// The line below has been corrected from '.' to ':'
import 'package:flutter_proj/utils/location_helper.dart';
import 'package:flutter_proj/widgets/search_bar.dart';
import 'package:flutter_proj/widgets/weather_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService =
      WeatherService(apiKey: 'bcbaa04c1cefb41909a0ed3b0c79a840');
  Weather? _weather;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCurrentUserLocation();
  }

  Future<void> _fetchWeatherForCurrentUserLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await LocationHelper.getCurrentLocation();
      final weather = await _weatherService.fetchWeatherByCoords(
          position.latitude, position.longitude);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchWeatherForCity(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final weather = await _weatherService.fetchWeatherByCity(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchWidget(onSearch: _fetchWeatherForCity),
              const SizedBox(height: 20),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (_weather != null) {
      return WeatherDisplay(weather: _weather!);
    }
    return const Center(child: Text('Search for a city to get weather data.'));
  }
}
