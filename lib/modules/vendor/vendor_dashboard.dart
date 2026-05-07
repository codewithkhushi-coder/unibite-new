import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'vendor_orders_screen.dart';
import 'vendor_menu_screen.dart';
import 'vendor_earnings_screen.dart';
import 'vendor_profile_screen.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  int currentIndex = 0;

  final pages = const [
    VendorOrdersScreen(),
    VendorMenuScreen(),
    VendorEarningsScreen(),
    VendorProfileScreen(),
  ];

  final _navItems = const [
    {'icon': Icons.receipt_long_rounded, 'label': 'Orders'},
    {'icon': Icons.restaurant_menu_rounded, 'label': 'Menu'},
    {'icon': Icons.currency_rupee_rounded, 'label': 'Earnings'},
    {'icon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPink.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (i) => setState(() => currentIndex = i),
            selectedItemColor: AppColors.primaryPink,
            unselectedItemColor: AppColors.textSecondary,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            elevation: 0,
            items: _navItems
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item['icon'] as IconData),
                      activeIcon: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(item['icon'] as IconData,
                            color: AppColors.primaryPink),
                      ),
                      label: item['label'] as String,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
