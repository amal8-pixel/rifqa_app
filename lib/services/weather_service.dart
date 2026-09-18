import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<Map<String, dynamic>> getWeather() async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=21.42&longitude=39.83&current=temperature_2m,weather_code',
    );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load weather');
    }

    final data = jsonDecode(response.body);

    final current = data['current'];

    String weatherText = 'صحو';

    final code = current['weather_code'];

    if (code >= 1 && code <= 3) {
      weatherText = 'غائم جزئيًا';
    } else if (code >= 51 && code <= 67) {
      weatherText = 'ممطر';
    } else if (code >= 95) {
      weatherText = 'عاصفة';
    }

    return {
      'temp': current['temperature_2m'],
      'condition': weatherText,
    };
  }
}
