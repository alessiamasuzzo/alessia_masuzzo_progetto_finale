import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final String city;
  final double temperature;
  final int code;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.code,
  });
}

class CityNotFoundException implements Exception {}

class WeatherService {
  Future<WeatherData> getWeatherByCity(String city) async {

    final geoUrl = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': city,
      'count': '1',
      'language': 'it',
    });
    final geoResponse = await http.get(geoUrl);
    if (geoResponse.statusCode != 200) {
      throw Exception('Errore ricerca città');
    }

    final results = jsonDecode(geoResponse.body)['results'] as List?;
    if (results == null || results.isEmpty) {
      throw CityNotFoundException();
    }
    final place = results[0];

    final weatherUrl = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '${place['latitude']}',
      'longitude': '${place['longitude']}',
      'current': 'temperature_2m,weather_code',
    });
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('Errore meteo');
    }

    final current = jsonDecode(weatherResponse.body)['current'];

    return WeatherData(
      city: place['name'] as String,
      temperature: (current['temperature_2m'] as num).toDouble(),
      code: current['weather_code'] as int,
    );
  }
}