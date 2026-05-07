import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String selectedRole = "customer";

  final nameController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  void signupByRole(BuildContext context) {
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
      appBar: AppBar(
        title: const Text("Sign Up ✨"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                labelText: "Email or Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedRole,
              decoration: const InputDecoration(
                labelText: "Sign Up As",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "customer",
                  child: Text("Customer"),
                ),
                DropdownMenuItem(
                  value: "vendor",
                  child: Text("Vendor"),
                ),
                DropdownMenuItem(
                  value: "delivery",
                  child: Text("Delivery Boy"),
                ),
                DropdownMenuItem(
                  value: "admin",
                  child: Text("Admin"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => signupByRole(context),
                child: const Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}