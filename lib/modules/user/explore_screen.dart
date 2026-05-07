import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.local_offer),
          title: Text("Top Offers"),
        ),
        ListTile(
          leading: Icon(Icons.trending_up),
          title: Text("Trending Now"),
        ),
      ],
    );
  }
}