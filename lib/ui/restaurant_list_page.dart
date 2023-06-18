import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_withapi/widgets/card_restaurant.dart';

import '../provider/restaurant_list_provider.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildSearchBar(),
          _buildRestaurantList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 150.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Restaurant',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Recommendation restaurant for you!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        floating: true,
        pinned: true,
        flexibleSpace: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search for a restaurant',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onChanged: (value) {
            setState(() {}); // Update the filtered list on search query change
          },
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state.state == ResultState.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
              childCount: state.result.restaurants.length,
            ),
          );
        } else if (state.state == ResultState.noData) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state.state == ResultState.error) {
          return SliverFillRemaining(
            child: Center(
              child: Material(
                child: Text(state.message),
              ),
            ),
          );
        } else {
          return SliverFillRemaining(
            child: const Center(
              child: Material(
                child: Text(''),
              ),
            ),
          );
        }
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}