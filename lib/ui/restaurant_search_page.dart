import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_withapi/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_withapi/ui/restaurant_list_search_page.dart';

import '../data/api/api_service.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search_page';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (context) => RestaurantSearchProvider(
        apiService: ApiService(),
        text: '', // Provide the desired search text here
      ),
      child: RestaurantListSearchPage(),
    );
  }
}
