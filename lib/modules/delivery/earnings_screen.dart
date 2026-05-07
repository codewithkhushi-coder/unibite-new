import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'label': "Today", 'value': '₹820', 'icon': Icons.today_rounded},
      {'label': 'This Week', 'value': '₹4,200', 'icon': Icons.calendar_view_week_rounded},
      {'label': 'Orders Done', 'value': '18', 'icon': Icons.check_circle_rounded},
      {'label': 'Rating', 'value': '4.8 ⭐', 'icon': Icons.star_rounded},
    ];

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
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                Text(
                  "My Earnings 💸",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Hero card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryPink, AppColors.lightPink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Earned",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "₹18,750",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.trending_up_rounded,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "+12% this week",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.5,
                  children: stats.map((s) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPink.withOpacity(0.08),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(s['icon'] as IconData,
                              color: AppColors.primaryPink, size: 22),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s['value'] as String,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                s['label'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}