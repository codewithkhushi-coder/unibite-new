import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import 'add_edit_food_screen.dart';

class VendorMenuScreen extends StatefulWidget {
  const VendorMenuScreen({super.key});

  @override
  State<VendorMenuScreen> createState() => _VendorMenuScreenState();
}

class _VendorMenuScreenState extends State<VendorMenuScreen> {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Margherita Pizza",
      "price": "199",
      "description": "Cheesy classic pizza",
      "available": true,
    },
    {
      "name": "Cheese Burger",
      "price": "149",
      "description": "Loaded cheese burger",
      "available": true,
    },
    {
      "name": "Masala Chai",
      "price": "20",
      "description": "Hot spiced tea",
      "available": false,
    },
  ];

  void _openAdd() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddEditFoodScreen()),
      );

  void _openEdit(Map<String, dynamic> item) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddEditFoodScreen(
            initialName: item["name"],
            initialPrice: item["price"],
            initialDescription: item["description"],
            initialAvailable: item["available"],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        backgroundColor: AppColors.primaryPink,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "Add Item",
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 4,
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Text(
                    "My Menu 🍔",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 14),
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return GlassmorphismContainer(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightPink.withOpacity(0.5),
                                    AppColors.primaryPink.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: Icon(Icons.lunch_dining_rounded,
                                  color: AppColors.primaryPink, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "₹${item["price"]} • ${item["description"]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: item["available"]
                                        ? AppColors.success.withOpacity(0.12)
                                        : AppColors.textHint
                                            .withOpacity(0.15),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item["available"]
                                        ? "Available"
                                        : "Off",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: item["available"]
                                          ? AppColors.success
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () => _openEdit(item),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryPink
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.edit_rounded,
                                      size: 16,
                                      color: AppColors.primaryPink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
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
