import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_withapi/widgets/card_restaurant_detail.dart';

import '../data/model/restaurant_detail.dart';
import '../provider/restauran_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail'),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, restaurantDetailProvider, _) {
          return FutureBuilder<RestaurantDetailResponse>(
            future: restaurantDetailProvider.apiService.restaurantDetail(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData ||
                  snapshot.data!.restaurant == null) {
                return const Center(child: Text('No data available'));
              } else {
                final restaurantDetail = snapshot.data!.restaurant!;
                return CardRestaurantDetail(restaurantDetail: restaurantDetail);
              }
            },
          );
        },
      ),
    );
  }
}
