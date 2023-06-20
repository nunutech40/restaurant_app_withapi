import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_withapi/provider/restauran_detail_provider.dart';
import 'package:restaurant_app_withapi/ui/home_page.dart';
import 'package:restaurant_app_withapi/ui/restaurant_detail_page.dart';

import 'package:restaurant_app_withapi/data/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
          // Your theme data
          ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is Map<String, dynamic>) {
            final id = arguments['id'] as String;
            return ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (context) => RestaurantDetailProvider(
                apiService:
                    ApiService(), // Provide your API service instance here
                id: id,
              ),
              child: RestaurantDetailPage(id: id),
            );
          }
          throw Exception('Invalid arguments provided');
        },
      },
    );
  }
}
