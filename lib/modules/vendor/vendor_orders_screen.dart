import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';

class VendorOrdersScreen extends StatelessWidget {
  const VendorOrdersScreen({super.key});

  final _orders = const [
    {"item": "2x Margherita Pizza", "customer": "Khushi", "amount": "₹399", "status": "New"},
    {"item": "Burger Combo", "customer": "Aman", "amount": "₹249", "status": "Preparing"},
    {"item": "Masala Chai x3", "customer": "Riya", "amount": "₹60", "status": "Ready"},
  ];

  Color _statusColor(String s) {
    if (s == 'New') return AppColors.primaryPink;
    if (s == 'Preparing') return const Color(0xFFF59E0B);
    return AppColors.success;
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
              width: 240,
              height: 240,
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Text(
                    "Incoming Orders 📦",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    itemCount: _orders.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 14),
                    itemBuilder: (_, i) {
                      final o = _orders[i];
                      return GlassmorphismContainer(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightPink.withOpacity(0.5),
                                    AppColors.primaryPink.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: Icon(Icons.fastfood_rounded,
                                  color: AppColors.primaryPink, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    o['item']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "Customer: ${o['customer']}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary),
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
                                    borderRadius:
                                        BorderRadius.circular(20),
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
