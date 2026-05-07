import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'cart/cart_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    OrdersScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final _navItems = const [
    {'icon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.receipt_long_rounded, 'label': 'Orders'},
    {'icon': Icons.shopping_bag_rounded, 'label': 'Cart'},
    {'icon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _PremiumNavBar(
        currentIndex: _currentIndex,
        items: _navItems,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _PremiumNavBar extends StatelessWidget {
  final int currentIndex;
  final List<Map<String, dynamic>> items;
  final ValueChanged<int> onTap;

  const _PremiumNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.18),
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final selected = i == currentIndex;

          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: selected ? 18 : 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                gradient: selected
                    ? const LinearGradient(
                        colors: [AppColors.primaryPink, AppColors.lightPink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                borderRadius: BorderRadius.circular(24),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppColors.primaryPink.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: selected ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      item['icon'] as IconData,
                      color: selected ? Colors.white : AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                  if (selected) ...[
                    const SizedBox(width: 6),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}