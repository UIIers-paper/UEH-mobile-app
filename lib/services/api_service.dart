import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ueh_mobile_app/configs/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // nhớ import

class ApiService {
  final String apiUrl;
  final _storage = FlutterSecureStorage();



  ApiService(this.apiUrl);

  Future<T> fetchData<T>(T Function(Map<String, dynamic>) fromJson) async {
    final response = await ApiConstants.client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('Get data');
      print(jsonData);
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to load data from API');
    }
  }
  Future<T> fetchDataList<T>(T Function(List<dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('Get datalist');
      print(jsonData);
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<T> getWithQueryParams<T>(
      Map<String, dynamic> queryParams,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    final uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
    final token = await _storage.read(key: 'token');

    final headers = {
      'accept': '*/*',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await ApiConstants.client.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print('✅ Phản hồi JSON: $jsonData (${jsonData.runtimeType})');
      return fromJson(jsonData);
    } else {
      throw Exception('Failed to load data from API with query params');
    }
  }

  Future<List<T>> getListWithQueryParams<T>(
      Map<String, dynamic> queryParams,
      T Function(Map<String, dynamic>) fromJson,
      ) async {
    final uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    final token = await _storage.read(key: 'token');
    final headers = {
      'accept': '*/*',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await ApiConstants.client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List;
      print('✅ Phản hồi danh sách JSON: $jsonList');
      return jsonList.map((e) => fromJson(e)).toList();
    } else {
      throw Exception('Failed to load list from API');
    }
  }

  Future<http.Response> postData(Map<String, dynamic> body) async {
    final response = await ApiConstants.client.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return response;
  }
}