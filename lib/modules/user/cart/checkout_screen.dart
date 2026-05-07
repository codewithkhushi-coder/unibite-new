import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final int total;

  const CheckoutScreen({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout 💳"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Delivery Address"),
                subtitle: const Text("Hostel Block A, Room 203"),
              ),
            ),
            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.payment),
                title: const Text("Payment Method"),
                subtitle: const Text("Cash on Delivery"),
              ),
            ),

            const Spacer(),

            Row(
              children: [
                const Text(
                  "Payable",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  "₹$total",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0073),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Order Placed Successfully 🎉"),
                    ),
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Place Order"),
              ),
            )
          ],
        ),
      ),
    );
  }
}