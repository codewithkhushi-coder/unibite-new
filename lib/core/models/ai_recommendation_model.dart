class AIRecommendation {
  final String foodName;
  final String reason;
  final String shortRecommendation;
  final String emoji;
  final String price;

  AIRecommendation({
    required this.foodName,
    required this.reason,
    required this.shortRecommendation,
    this.emoji = '🍱',
    this.price = '₹120',
  });

  factory AIRecommendation.fromJson(Map<String, dynamic> json) {
    return AIRecommendation(
      foodName: json['food_name'] ?? 'Tasty Meal',
      reason: json['reason'] ?? 'Highly recommended for you!',
      shortRecommendation: json['short_recommendation'] ?? 'AI Pick',
      emoji: json['emoji'] ?? '🍔',
      price: json['price'] ?? '₹99',
    );
  }
}
