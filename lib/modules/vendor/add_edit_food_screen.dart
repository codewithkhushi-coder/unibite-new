import 'package:flutter/material.dart';

class AddEditFoodScreen extends StatefulWidget {
  final String? initialName;
  final String? initialPrice;
  final String? initialDescription;
  final bool initialAvailable;

  const AddEditFoodScreen({
    super.key,
    this.initialName,
    this.initialPrice,
    this.initialDescription,
    this.initialAvailable = true,
  });

  @override
  State<AddEditFoodScreen> createState() => _AddEditFoodScreenState();
}

class _AddEditFoodScreenState extends State<AddEditFoodScreen> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;
  late bool isAvailable;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.initialName ?? "");
    priceController =
        TextEditingController(text: widget.initialPrice ?? "");
    descriptionController =
        TextEditingController(text: widget.initialDescription ?? "");
    isAvailable = widget.initialAvailable;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveFoodItem() {
    // later: save to Supabase
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Food item saved ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialName != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Food ✏️" : "Add Food ➕"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Food Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Price",
                border: OutlineInputBorder(),
                prefixText: "₹ ",
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            SwitchListTile(
              value: isAvailable,
              title: const Text("Available"),
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                });
              },
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveFoodItem,
                child: Text(isEdit ? "Update Item" : "Add Item"),
              ),
            )
          ],
        ),
      ),
    );
  }
}