import 'dart:async';

import 'package:restaurant_app_withapi/data/api/api_service.dart';
import 'package:flutter/material.dart';

import '../data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _restaurantDetailResult = RestaurantDetailResponse(
      error: true,
      message: '',
      restaurant: null,
    );
    _fetchRestaurantDetailAll(id);
  }

  late RestaurantDetailResponse _restaurantDetailResult;
  ResultState _state = ResultState.loading;
  String _message = '';
  dynamic _error;

  String get message => _message;

  RestaurantDetailResponse get result => _restaurantDetailResult;

  ResultState get state => _state;

  dynamic get error => _error;

  Future<void> _fetchRestaurantDetailAll(String id) async {
    try {
      final restaurantDetail = await apiService.restaurantDetail(id);
      _restaurantDetailResult = restaurantDetail;

      if (_restaurantDetailResult.restaurant == null) {
        _state = ResultState.noData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      _error = e;
    } finally {
      notifyListeners();
    }
  }
}
