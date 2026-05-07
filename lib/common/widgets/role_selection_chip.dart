import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class RoleSelectionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleSelectionChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryPink : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: AppColors.primaryPink.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
            ],
            border: Border.all(
              color: isSelected ? AppColors.primaryPink : Colors.grey.shade300,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
