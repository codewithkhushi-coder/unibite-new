import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../common/widgets/glassmorphism_container.dart';
import 'cart_service.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                color: AppColors.primaryPink.withOpacity(0.13),
              ),
            ),
          ),
          SafeArea(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: CartService.instance.cartItems,
              builder: (context, items, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Row(
                        children: [
                          Text(
                            'My Cart 🛒',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          if (items.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryPink.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${items.length} item${items.length > 1 ? 's' : ''}',
                                style: TextStyle(
                                  color: AppColors.primaryPink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Empty state
                    if (items.isEmpty)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryPink.withOpacity(0.08),
                                ),
                                child: Icon(Icons.shopping_bag_outlined,
                                    size: 56, color: AppColors.primaryPink),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Your cart is empty',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add items from a canteen to get started',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else ...[
                      // Cart items
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (_, i) =>
                              _CartItemCard(item: items[i], index: i),
                        ),
                      ),

                      // Bill summary + checkout
                      _CheckoutPanel(items: items),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final int index;
  const _CartItemCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    return GlassmorphismContainer(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.lightPink.withOpacity(0.5),
                  AppColors.primaryPink.withOpacity(0.3),
                ],
              ),
            ),
            child: Icon(Icons.fastfood_rounded,
                color: AppColors.primaryPink, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'].toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '₹${item["price"]}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryPink,
                  ),
                ),
              ],
            ),
          ),
          // Qty controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QtyBtn(
                  icon: Icons.remove_rounded,
                  onTap: () => cart.updateQty(index, -1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${item["qty"]}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                _QtyBtn(
                  icon: Icons.add_rounded,
                  onTap: () => cart.updateQty(index, 1),
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;
  const _QtyBtn(
      {required this.icon, required this.onTap, this.isPrimary = false});

  @override
  State<_QtyBtn> createState() => _QtyBtnState();
}

class _QtyBtnState extends State<_QtyBtn> {
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: widget.isPrimary
              ? const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.lightPink],
                )
              : null,
          color: widget.isPrimary ? null : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          widget.icon,
          size: 16,
          color: widget.isPrimary ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _CheckoutPanel({required this.items});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final subtotal = cart.total;
    const delivery = 30;
    final total = subtotal + delivery;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Summary',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _BillRow(label: 'Subtotal', value: '₹$subtotal'),
          _BillRow(label: 'Delivery fee', value: '₹$delivery'),
          const Divider(height: 20),
          _BillRow(label: 'Total', value: '₹$total', isBold: true),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CheckoutScreen(total: total),
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryPink, AppColors.lightPink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPink.withOpacity(0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_checkout_rounded,
                      color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Checkout  ₹$total',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
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

class _BillRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _BillRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 15 : 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
              color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 16 : 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              color: isBold ? AppColors.primaryPink : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}