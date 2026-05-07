import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import '../../core/routes/app_routes.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  bool isOpen = true;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                Text(
                  "Restaurant Profile 🏪",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // Profile card
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
                        child: const Icon(Icons.storefront_rounded,
                            size: 34, color: Colors.white),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pizza Hub 🍕",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Canteen Vendor",
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

                const SizedBox(height: 20),

                // Open/Close toggle
                GlassmorphismContainer(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 6),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Restaurant Open",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      isOpen ? "Accepting orders" : "Not accepting orders",
                      style: TextStyle(
                        fontSize: 12,
                        color: isOpen
                            ? AppColors.success
                            : AppColors.textSecondary,
                      ),
                    ),
                    value: isOpen,
                    activeColor: AppColors.primaryPink,
                    onChanged: (v) => setState(() => isOpen = v),
                  ),
                ),

                const SizedBox(height: 20),

                // Logout
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, AppRoutes.login),
                  child: GlassmorphismContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.logout_rounded,
                              color: AppColors.error, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.chevron_right_rounded,
                            color: AppColors.textHint),
                      ],
                    ),
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
