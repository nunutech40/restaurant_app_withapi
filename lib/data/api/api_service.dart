import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_withapi/data/model/restaurant_detail.dart';
import 'package:restaurant_app_withapi/data/model/restaurant_list.dart';
import 'package:restaurant_app_withapi/data/model/restaurant_list_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _restaurantListEndPoint = '/list';
  static const String _restaurantDetailEndPoint = '/detail';
  static const String _restaurantSearchEndPoint = '/search?q=';

  Future<RestaurantResponse> restauranList() async {
    final response =
        await http.get(Uri.parse(_baseUrl + _restaurantListEndPoint));

    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> restaurantDetail(String id) async {
    final response = await http
        .get(Uri.parse(_baseUrl + _restaurantDetailEndPoint + "/" + id));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<SearchResponse> restaurantSearch(String text) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _restaurantSearchEndPoint + text));
    print("cek dataaaaa: ${response.body}");
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
