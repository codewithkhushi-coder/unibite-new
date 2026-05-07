import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import '../../core/routes/app_routes.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final _stats = const [
    {'label': 'Total Users', 'value': '1,248', 'icon': Icons.people_rounded},
    {'label': 'Active Vendors', 'value': '34', 'icon': Icons.storefront_rounded},
    {'label': "Today's Revenue", 'value': '₹58,200', 'icon': Icons.currency_rupee_rounded},
    {'label': 'Live Orders', 'value': '72', 'icon': Icons.receipt_long_rounded},
  ];

  final _quickActions = const [
    {'label': 'Manage Users', 'icon': Icons.manage_accounts_rounded},
    {'label': 'Vendors', 'icon': Icons.store_rounded},
    {'label': 'Analytics', 'icon': Icons.bar_chart_rounded},
    {'label': 'Settings', 'icon': Icons.settings_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative blobs — identical to login screen
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPink.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPink.withOpacity(0.25),
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  // ── Header ──
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin Panel 🛡️",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Control Center",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, AppRoutes.login),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.logout_rounded,
                              color: AppColors.error, size: 20),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Stats Grid ──
                  Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.45,
                    children: _stats.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 400 + i * 100),
                        curve: Curves.easeOut,
                        builder: (_, val, child) => Opacity(
                          opacity: val,
                          child: Transform.translate(
                              offset: Offset(0, 16 * (1 - val)),
                              child: child),
                        ),
                        child: _StatCard(
                          label: s['label'] as String,
                          value: s['value'] as String,
                          icon: s['icon'] as IconData,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // ── Quick Actions ──
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 2.0,
                    children: _quickActions.map((action) {
                      return GestureDetector(
                        onTap: () {},
                        child: GlassmorphismContainer(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryPink,
                                      AppColors.lightPink
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(action['icon'] as IconData,
                                    color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  action['label'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // ── Recent Activity ──
                  Text(
                    "Recent Activity",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GlassmorphismContainer(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        _ActivityTile(
                          icon: Icons.person_add_rounded,
                          text: 'New user registered: Aman Singh',
                          time: '2 min ago',
                        ),
                        _ActivityTile(
                          icon: Icons.store_rounded,
                          text: 'New vendor approved: Gossip Canteen',
                          time: '15 min ago',
                        ),
                        _ActivityTile(
                          icon: Icons.warning_amber_rounded,
                          text: 'Order complaint raised #102',
                          time: '1 hr ago',
                          isAlert: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatCard(
      {required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryPink, AppColors.lightPink],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final bool isAlert;
  const _ActivityTile(
      {required this.icon,
      required this.text,
      required this.time,
      this.isAlert = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isAlert
              ? AppColors.error.withOpacity(0.1)
              : AppColors.primaryPink.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            color: isAlert ? AppColors.error : AppColors.primaryPink,
            size: 18),
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 13, color: AppColors.textPrimary),
      ),
      trailing: Text(
        time,
        style: TextStyle(fontSize: 11, color: AppColors.textHint),
      ),
    );
  }
}