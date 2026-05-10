class MenuItem {
  final String id;
  final String name;
  final double price;
  final String emoji;
  final String category;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.emoji,
    required this.category,
  });
}

class Canteen {
  final String id;
  final String name;
  final String description;
  final double rating;
  final String deliveryTime;
  final double latitude;
  final double longitude;
  final List<MenuItem> menu;
  final String tag;

  Canteen({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.deliveryTime,
    required this.latitude,
    required this.longitude,
    required this.menu,
    this.tag = '',
  });
}

final List<Canteen> mockCanteens = [
  Canteen(
    id: '1',
    name: 'Gossip Canteen',
    description: 'Snacks, burgers & more',
    rating: 4.5,
    deliveryTime: '15-20 mins',
    latitude: 32.7161,
    longitude: 74.8694,
    tag: 'Trending 🔥',
    menu: [
      MenuItem(id: 'g1', name: 'Veg Burger', price: 120, emoji: '🍔', category: 'Burger'),
      MenuItem(id: 'g2', name: 'Farmhouse Pizza', price: 180, emoji: '🍕', category: 'Pizza'),
      MenuItem(id: 'g3', name: 'Veg Momos', price: 60, emoji: '🥟', category: 'Momos'),
      MenuItem(id: 'g4', name: 'Cold Coffee', price: 80, emoji: '🥤', category: 'Coffee'),
      MenuItem(id: 'g5', name: 'Club Sandwich', price: 110, emoji: '🥪', category: 'Sandwich'),
      MenuItem(id: 'g6', name: 'French Fries', price: 90, emoji: '🍟', category: 'Fries'),
    ],
  ),
  Canteen(
    id: '2',
    name: 'Distance Canteen',
    description: 'Full meals & thalis',
    rating: 4.2,
    deliveryTime: '20-25 mins',
    latitude: 32.7175,
    longitude: 74.8710,
    tag: 'Popular 👍',
    menu: [
      MenuItem(id: 'd1', name: 'Cheese Burger', price: 100, emoji: '🍔', category: 'Burger'),
      MenuItem(id: 'd2', name: 'Grilled Sandwich', price: 70, emoji: '🥪', category: 'Sandwich'),
      MenuItem(id: 'd3', name: 'Peri Peri Fries', price: 60, emoji: '🍟', category: 'Fries'),
      MenuItem(id: 'd4', name: 'Veg Thali', price: 150, emoji: '🍱', category: 'Meals'),
      MenuItem(id: 'd5', name: 'Masala Pizza', price: 160, emoji: '🍕', category: 'Pizza'),
    ],
  ),
  Canteen(
    id: '3',
    name: 'Sharma Tea Stall',
    description: 'Chai, snacks & Maggi',
    rating: 4.8,
    deliveryTime: '5-10 mins',
    latitude: 32.7185,
    longitude: 74.8725,
    tag: 'Top Rated ⭐',
    menu: [
      MenuItem(id: 's1', name: 'Masala Tea', price: 20, emoji: '☕', category: 'Tea'),
      MenuItem(id: 's2', name: 'Veg Maggi', price: 40, emoji: '🍜', category: 'Maggi'),
      MenuItem(id: 's3', name: 'Aloo Burger', price: 90, emoji: '🍔', category: 'Burger'),
      MenuItem(id: 's4', name: 'Bun Maska', price: 30, emoji: '🥯', category: 'Snacks'),
      MenuItem(id: 's5', name: 'Steam Momos', price: 50, emoji: '🥟', category: 'Momos'),
      MenuItem(id: 's6', name: 'Lemon Tea', price: 25, emoji: '☕', category: 'Tea'),
    ],
  ),
];
