import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import '../../core/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.location_on_rounded, 'label': 'Saved Addresses'},
      {'icon': Icons.payment_rounded, 'label': 'Payments'},
      {'icon': Icons.notifications_rounded, 'label': 'Notifications'},
      {'icon': Icons.help_outline_rounded, 'label': 'Help & Support'},
      {'icon': Icons.logout_rounded, 'label': 'Logout'},
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
                color: AppColors.primaryPink.withOpacity(0.18),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: -70,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPink.withOpacity(0.2),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Avatar card
                GlassmorphismContainer(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryPink,
                              AppColors.lightPink
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPink.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.person_rounded,
                            size: 36, color: Colors.white),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Khushi 👤",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Student • Block A",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Menu items
                ...menuItems.map((item) {
                  final isLogout = item['label'] == 'Logout';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        if (isLogout) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        }
                      },
                      child: GlassmorphismContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isLogout
                                    ? AppColors.error.withOpacity(0.1)
                                    : AppColors.primaryPink.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                color: isLogout
                                    ? AppColors.error
                                    : AppColors.primaryPink,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item['label'] as String,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isLogout
                                      ? AppColors.error
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                color: AppColors.textHint),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}