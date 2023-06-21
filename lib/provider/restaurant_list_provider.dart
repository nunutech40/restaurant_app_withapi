import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurant_app_withapi/data/api/api_service.dart';
import 'package:restaurant_app_withapi/data/model/restaurant_list.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurantListAll();
  }

  late RestaurantResponse _restaurantResult;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  RestaurantResponse get result => _restaurantResult;

  ResultState get state => _state;

  Future<void> _fetchRestaurantListAll() async {
    try {
      final isConnected = await InternetConnectionChecker().hasConnection;

      if (!isConnected) {
        _state = ResultState.error;
        _message =
            'No internet connection. Please check your internet connection and try again.';
        notifyListeners();
        return;
      }

      final restaurantList = await apiService.restauranList();
      _restaurantResult = restaurantList;

      if (_restaurantResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'An error occurred while fetching restaurant data: $e';
    } finally {
      notifyListeners();
    }
  }
}
