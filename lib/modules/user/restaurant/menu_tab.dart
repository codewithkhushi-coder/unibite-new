import 'package:flutter/material.dart';
import '../cart/cart_service.dart';

class MenuTab extends StatelessWidget {
  final VoidCallback? onAddToCart;

  const MenuTab({super.key, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menu = [
      {
        "name": "Margherita Pizza",
        "price": 199,
        "desc": "Classic cheesy delight",
      },
      {
        "name": "Farmhouse Pizza",
        "price": 299,
        "desc": "Loaded veggies + cheese",
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: menu.map((item) {
        return Card(
          child: ListTile(
            title: Text(item["name"].toString()),
            subtitle: Text(
              "${item["desc"]}\n₹${item["price"]}",
            ),
            trailing: ElevatedButton(
              onPressed: () {
                CartService.instance.addItem(item);
                onAddToCart?.call();
              },
              child: const Text("ADD"),
            ),
          ),
        );
      }).toList(),
    );
  }
}