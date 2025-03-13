import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<T> fetchData<T>(T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)[0];
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
  Future<T> fetchDataList<T>(T Function(List<dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)[0];
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}