import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.opacity = 0.2,
    this.borderRadius = 20.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
