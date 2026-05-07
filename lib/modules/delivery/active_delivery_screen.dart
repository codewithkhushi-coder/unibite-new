import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';

class ActiveDeliveryScreen extends StatelessWidget {
  const ActiveDeliveryScreen({super.key});

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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                Text(
                  "Active Delivery 🛵",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                // Map placeholder
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lightPink.withOpacity(0.4),
                        AppColors.primaryPink.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map_rounded,
                          size: 48, color: AppColors.primaryPink),
                      const SizedBox(height: 8),
                      Text(
                        "Live Map",
                        style: TextStyle(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Route info
                GlassmorphismContainer(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _RoutePoint(
                        icon: Icons.store_rounded,
                        label: "Pickup",
                        place: "Pizza Hub",
                        sub: "Mall Road",
                        color: AppColors.primaryPink,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: List.generate(
                            3,
                            (_) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              width: 2,
                              height: 6,
                              color:
                                  AppColors.primaryPink.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                      _RoutePoint(
                        icon: Icons.home_rounded,
                        label: "Drop",
                        place: "Hostel Block A",
                        sub: "University Gate",
                        color: AppColors.success,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ETA chip
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPink.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 16, color: AppColors.primaryPink),
                        const SizedBox(width: 6),
                        Text(
                          "ETA: 18 mins",
                          style: TextStyle(
                            color: AppColors.primaryPink,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: "Accept",
                        icon: Icons.check_circle_rounded,
                        isPrimary: true,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _ActionButton(
                        label: "Delivered",
                        icon: Icons.done_all_rounded,
                        isPrimary: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  final IconData icon;
  final String label;
  final String place;
  final String sub;
  final Color color;
  const _RoutePoint(
      {required this.icon,
      required this.label,
      required this.place,
      required this.sub,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary)),
            Text(place,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.textPrimary)),
            Text(sub,
                style: TextStyle(
                    fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;
  const _ActionButton(
      {required this.label,
      required this.icon,
      required this.isPrimary,
      required this.onTap});

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: [AppColors.primaryPink, AppColors.lightPink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.isPrimary ? null : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: AppColors.primaryPink.withOpacity(0.4),
                    width: 1.5),
            boxShadow: widget.isPrimary
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color:
                    widget.isPrimary ? Colors.white : AppColors.primaryPink,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color:
                      widget.isPrimary ? Colors.white : AppColors.primaryPink,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
