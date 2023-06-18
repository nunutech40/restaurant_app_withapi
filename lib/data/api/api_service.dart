import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_withapi/data/model/restaurant_list.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _endPoint = '/list';

  Future<RestaurantResponse> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl + _endPoint));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
