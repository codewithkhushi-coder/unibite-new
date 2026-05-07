import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import '../../common/widgets/role_selection_chip.dart';
import '../../common/widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedRole;
  bool isPasswordVisible = false;
  bool isLoading = false;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final List<Map<String, dynamic>> roles = [
    {"id": "customer", "label": "User", "icon": Icons.person},
    {"id": "admin", "label": "Admin", "icon": Icons.admin_panel_settings},
    {"id": "vendor", "label": "Canteen Vendor", "icon": Icons.storefront},
    {"id": "delivery", "label": "Delivery Boy", "icon": Icons.delivery_dining},
  ];

  void loginByRole(BuildContext context) async {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a role before logging in."),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (!context.mounted) return;

    switch (selectedRole) {
      case "customer":
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case "vendor":
        Navigator.pushReplacementNamed(context, AppRoutes.vendor);
        break;
      case "delivery":
        Navigator.pushReplacementNamed(context, AppRoutes.delivery);
        break;
      case "admin":
        Navigator.pushReplacementNamed(context, AppRoutes.admin);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Stack(
          children: [
            // Decorative background elements for glassmorphism
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
            
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back 👋",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sign in to continue to UniBite",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    GlassmorphismContainer(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Your Role",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Role Selection
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            child: Row(
                              children: roles.map((role) {
                                return RoleSelectionChip(
                                  label: role["label"],
                                  icon: role["icon"],
                                  isSelected: selectedRole == role["id"],
                                  onTap: () {
                                    setState(() {
                                      selectedRole = role["id"];
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Login Fields
                          TextField(
                            controller: loginController,
                            decoration: InputDecoration(
                              labelText: "Email or Phone",
                              hintText: "Enter your email or phone",
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: AppColors.primaryPink, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          TextField(
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: AppColors.primaryPink, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Primary Button
                          GradientButton(
                            text: "Login",
                            isLoading: isLoading,
                            onPressed: () => loginByRole(context),
                          ),
                          const SizedBox(height: 20),
                          
                          // Secondary Text
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.signup);
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                        color: AppColors.primaryPink,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
}