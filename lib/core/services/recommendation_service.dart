import 'dart:convert';
import 'gemini_service.dart';
import '../models/ai_recommendation_model.dart';

class RecommendationService {
  final GeminiService _geminiService;

  RecommendationService(this._geminiService);

  Future<List<AIRecommendation>> getAIRecommendations() async {
    const prompt = '''
Suggest 3 delicious food items from a typical college campus canteen.
Consider time of day (Morning/Afternoon/Evening).
Return ONLY a JSON list of objects with these keys: "food_name", "reason", "short_recommendation", "emoji", "price".
Example: [{"food_name": "Veg Burger", "reason": "Quick and filling for a busy afternoon.", "short_recommendation": "Student Favorite", "emoji": "🍔", "price": "₹80"}]
Do NOT include any markdown formatting like ```json. Just return the raw JSON string.
''';

    final aiResponse = await _geminiService.askAI(prompt);
    
    try {
      String jsonStr = aiResponse.trim();
      // Gemini sometimes includes markdown even if told not to
      if (jsonStr.contains('```')) {
        jsonStr = jsonStr.split('```')[1];
        if (jsonStr.startsWith('json')) {
          jsonStr = jsonStr.substring(4);
        }
        jsonStr = jsonStr.split('```')[0].trim();
      }

      final List<dynamic> jsonList = jsonDecode(jsonStr);
      return jsonList.map((json) => AIRecommendation.fromJson(json)).toList();
    } catch (e) {
      print('Error parsing Gemini recommendations: $e');
      return [];
    }
  }
}
