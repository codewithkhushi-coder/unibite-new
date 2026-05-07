import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.background,
        child: Stack(
          children: [
            // ── Decorative blob — top right (same as login screen) ──
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryPink.withOpacity(0.3),
                ),
              ),
            ),

            // ── Decorative blob — bottom left (same as login screen) ──
            Positioned(
              bottom: -50,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightPink.withOpacity(0.4),
                ),
              ),
            ),

            // ── Center content ──
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo inside glassmorphism card — mirrors login card style
                    GlassmorphismContainer(
                      padding: const EdgeInsets.all(28),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryPink,
                              AppColors.lightPink,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPink.withOpacity(0.4),
                              blurRadius: 24,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.fastfood_rounded,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // App name
                    Text(
                      "UniBite",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Tagline — same secondary text color as login subtitle
                    Text(
                      "Your campus food, delivered fast 🍕",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Loading dots — accent pink, same as login's primaryPink
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryPink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}