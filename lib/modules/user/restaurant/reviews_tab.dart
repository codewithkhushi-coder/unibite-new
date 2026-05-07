import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        "name": "Khushi",
        "rating": "5.0",
        "review": "Amazing taste and super fast delivery 🔥",
      },
      {
        "name": "Aman",
        "rating": "4.5",
        "review": "Pizza was fresh and cheesy 😍",
      },
      {
        "name": "Riya",
        "rating": "4.0",
        "review": "Good packaging and nice offers",
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: reviews.map((review) {
        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(review["name"]!),
            subtitle: Text(review["review"]!),
            trailing: Text("⭐ ${review["rating"]}"),
          ),
        );
      }).toList(),
    );
  }
}