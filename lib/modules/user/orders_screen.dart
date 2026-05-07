import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final _orders = const [
    {
      'place': 'Pizza Hut 🍕',
      'items': '2x Margherita Pizza',
      'status': 'Delivered',
      'amount': '₹399',
      'date': 'Today, 1:30 PM',
    },
    {
      'place': 'Burger King 🍔',
      'items': 'Burger Combo',
      'status': 'On the way',
      'amount': '₹249',
      'date': 'Yesterday, 7:20 PM',
    },
    {
      'place': 'Sharma Tea Stall ☕',
      'items': '3x Masala Chai',
      'status': 'Delivered',
      'amount': '₹60',
      'date': '6 May, 9:10 AM',
    },
  ];

  Color _statusColor(String status) {
    if (status == 'Delivered') return AppColors.success;
    if (status == 'On the way') return AppColors.primaryPink;
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPink.withOpacity(0.15),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "My Orders 🧾",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, i) {
                      final o = _orders[i];
                      return GlassmorphismContainer(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightPink.withOpacity(0.6),
                                    AppColors.primaryPink.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: Icon(Icons.fastfood_rounded,
                                  color: AppColors.primaryPink, size: 24),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    o['place']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    o['items']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    o['date']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textHint,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  o['amount']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _statusColor(o['status']!)
                                        .withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    o['status']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _statusColor(o['status']!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}