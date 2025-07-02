import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class WeatherModel {
  static const String apiKey = 'YOUR_OPENWEATHERMAP_API_KEY';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getCityWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }

  Future<dynamic> getLocationWeather([double? lat, double? lon]) async {
    if (lat == null || lon == null) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lat = position.latitude;
      lon = position.longitude;
    }

    final response = await http.get(
      Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
