import 'package:flutter/material.dart';

class CartService {
  CartService._();

  static final CartService instance = CartService._();

  final ValueNotifier<List<Map<String, dynamic>>> cartItems =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  void addItem(Map<String, dynamic> item) {
    final items = [...cartItems.value];

    final index = items.indexWhere(
      (e) => e["name"] == item["name"],
    );

    if (index != -1) {
      items[index]["qty"] =
          (items[index]["qty"] as int) + 1;
    } else {
      items.add({
        ...item,
        "qty": 1,
      });
    }

    cartItems.value = items;
  }

  void updateQty(int index, int change) {
    final items = [...cartItems.value];

    items[index]["qty"] =
        (items[index]["qty"] as int) + change;

    if ((items[index]["qty"] as int) <= 0) {
      items.removeAt(index);
    }

    cartItems.value = items;
  }

  int get total {
    return cartItems.value.fold<int>(
      0,
      (sum, item) =>
          sum +
          (item["price"] as int) *
              (item["qty"] as int),
    );
  }

  int get itemCount {
    return cartItems.value.fold<int>(
      0,
      (sum, item) => sum + (item["qty"] as int),
    );
  }
}