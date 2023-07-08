import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _genresApiKey = '102d56a75dmsh94058f91e67e306p14b1b1jsn7ce44dce8e9a';
  static const String _titlesApiKey = '102d56a75dmsh94058f91e67e306p14b1b1jsn7ce44dce8e9a';
  static const String _baseUrl = 'https://moviesdatabase.p.rapidapi.com';

  Future<Map<String, dynamic>> getGenres() async {
    const String url = '$_baseUrl/titles/utils/genres';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': _genresApiKey,
        'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

  Future<Map<String, dynamic>> getTitlesByYear(int year, {int amount = 10}) async {
    final String url = '$_baseUrl/titles?limit=$amount&info=base_info&year=$year';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': _titlesApiKey,
        'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch titles');
    }
  }
}