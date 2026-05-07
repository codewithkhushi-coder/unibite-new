import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../common/widgets/glassmorphism_container.dart';
import 'restaurant/restaurant_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  int _bannerIndex = 0;

  final _banners = const [
    {'text': '50% OFF on first order 🎉', 'sub': 'Use code UNIBITE50'},
    {'text': 'Free delivery on ₹199+ 🛵', 'sub': 'Today only!'},
    {'text': 'New! Sharma Tea Stall ☕', 'sub': 'Now open for orders'},
  ];

  final _canteens = const [
    {
      'name': 'Gossip Corner',
      'desc': 'Snacks, burgers & more',
      'rating': '4.6',
      'time': '20 mins',
      'tag': 'Trending 🔥',
      'open': true,
      'icon': Icons.lunch_dining_rounded,
    },
    {
      'name': 'Distance Canteen',
      'desc': 'Full meals & thalis',
      'rating': '4.4',
      'time': '25 mins',
      'tag': 'Popular 👍',
      'open': true,
      'icon': Icons.rice_bowl_rounded,
    },
    {
      'name': 'Sharma Tea Stall',
      'desc': 'Chai, snacks & Maggi',
      'rating': '4.8',
      'time': '10 mins',
      'tag': 'Top Rated ⭐',
      'open': true,
      'icon': Icons.emoji_food_beverage_rounded,
    },
  ];

  final _chips = const [
    '🍕 Pizza', '🍔 Burgers', '☕ Chai', '🍜 Noodles', '🥗 Healthy', '🍩 Snacks',
  ];

  int _selectedChip = 0;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background blobs
          Positioned(
            top: -90,
            right: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPink.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightPink.withOpacity(0.18),
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Header ──
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome to UniBite 👋',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'What are you craving today?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              _NotifBell(),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ── Search Bar ──
                          _SearchBar(),

                          const SizedBox(height: 20),

                          // ── Banner Slider ──
                          _BannerSlider(
                            banners: _banners,
                            currentIndex: _bannerIndex,
                            onChanged: (i) => setState(() => _bannerIndex = i),
                          ),

                          const SizedBox(height: 24),

                          // ── Food Chips ──
                          Text(
                            'What\'s on your mind?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  // Horizontal chips
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 44,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _chips.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (_, i) {
                          final selected = i == _selectedChip;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedChip = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: selected
                                    ? const LinearGradient(
                                        colors: [
                                          AppColors.primaryPink,
                                          AppColors.lightPink
                                        ],
                                      )
                                    : null,
                                color: selected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: selected
                                      ? Colors.transparent
                                      : Colors.grey.shade200,
                                ),
                                boxShadow: selected
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primaryPink
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        )
                                      ]
                                    : [],
                              ),
                              child: Text(
                                _chips[i],
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                      child: Row(
                        children: [
                          Text(
                            'Nearby Canteens',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primaryPink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Canteen Cards
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 400 + i * 150),
                        curve: Curves.easeOut,
                        builder: (_, val, child) => Opacity(
                          opacity: val,
                          child: Transform.translate(
                            offset: Offset(0, 24 * (1 - val)),
                            child: child,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                          child: _CanteenCard(canteen: _canteens[i]),
                        ),
                      ),
                      childCount: _canteens.length,
                    ),
                  ),

                  // Recommended section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommended for you 💡',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 140,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: const [
                                _RecommendCard(name: 'Masala Chai', price: '₹20', emoji: '☕'),
                                _RecommendCard(name: 'Veg Thali', price: '₹80', emoji: '🍱'),
                                _RecommendCard(name: 'Cheese Burger', price: '₹149', emoji: '🍔'),
                                _RecommendCard(name: 'Maggi', price: '₹30', emoji: '🍜'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100), // space for nav bar
                        ],
                      ),
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

// ── Notification Bell ──────────────────────────────────────────────────────────
class _NotifBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.notifications_rounded,
              color: AppColors.primaryPink, size: 22),
          Positioned(
            top: 9,
            right: 9,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primaryPink,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Search Bar ─────────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(Icons.search_rounded, color: AppColors.primaryPink, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search canteens or dishes...',
                hintStyle: TextStyle(
                    color: AppColors.textHint, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryPink, AppColors.lightPink],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

// ── Banner Slider ──────────────────────────────────────────────────────────────
class _BannerSlider extends StatelessWidget {
  final List<Map<String, String>> banners;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const _BannerSlider({
    required this.banners,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: PageView.builder(
            onPageChanged: onChanged,
            itemCount: banners.length,
            itemBuilder: (_, i) {
              final b = banners[i];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryPink, AppColors.lightPink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPink.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            b['text']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            b['sub']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.local_offer_rounded,
                        color: Colors.white, size: 44),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == currentIndex ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == currentIndex
                    ? AppColors.primaryPink
                    : AppColors.primaryPink.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── Canteen Card ───────────────────────────────────────────────────────────────
class _CanteenCard extends StatefulWidget {
  final Map<String, dynamic> canteen;
  const _CanteenCard({required this.canteen});

  @override
  State<_CanteenCard> createState() => _CanteenCardState();
}

class _CanteenCardState extends State<_CanteenCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.canteen;
    final bool open = c['open'] as bool;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, a, __) => const RestaurantDetailsScreen(),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                    parent: anim, curve: Curves.easeOut)),
                child: child,
              ),
            ),
            transitionDuration: const Duration(milliseconds: 280),
          ),
        );
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPink.withOpacity(0.10),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Stack(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lightPink.withOpacity(0.55),
                          AppColors.primaryPink.withOpacity(0.28),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24)),
                    ),
                    child: Center(
                      child: Icon(
                        c['icon'] as IconData,
                        size: 68,
                        color: AppColors.primaryPink,
                      ),
                    ),
                  ),
                  // Open/Closed badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: open ? AppColors.success : Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            open ? 'Open' : 'Closed',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Tag badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        c['tag'] as String,
                        style: TextStyle(
                          color: AppColors.primaryPink,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            c['name'] as String,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryPink,
                                AppColors.lightPink
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPink.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      c['desc'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            size: 15, color: AppColors.primaryPink),
                        const SizedBox(width: 3),
                        Text(
                          c['rating'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Icon(Icons.access_time_rounded,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          c['time'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Recommended Card ───────────────────────────────────────────────────────────
class _RecommendCard extends StatelessWidget {
  final String name;
  final String price;
  final String emoji;

  const _RecommendCard({
    required this.name,
    required this.price,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPink.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryPink,
            ),
          ),
        ],
      ),
    );
  }
}