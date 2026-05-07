import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import 'menu_tab.dart';
import 'reviews_tab.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState
    extends State<RestaurantDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void addToCart() {
    setState(() {
      cartCount++;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.orange.shade100,
                child: const Center(
                  child: Icon(Icons.restaurant, size: 90),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "Pizza Hut 🍕",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text("⭐ 4.5"),
                  ],
                ),
              ),

              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFFFF0073),
                tabs: const [
                  Tab(text: "Menu"),
                  Tab(text: "Reviews"),
                ],
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    MenuTab(onAddToCart: addToCart),
                    const ReviewsTab(),
                  ],
                ),
              ),
            ],
          ),

          if (cartCount > 0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFFFF0073),
                  child: Row(
                    children: [
                      Text(
                        "$cartCount items in cart 🛒",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      const Text(
                        "View Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}