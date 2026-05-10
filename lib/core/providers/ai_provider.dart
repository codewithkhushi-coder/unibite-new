import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../services/recommendation_service.dart';
import '../models/ai_recommendation_model.dart';

class AIProvider extends ChangeNotifier {
  final GeminiService _geminiService = GeminiService();
  late final RecommendationService _recommendationService;

  List<AIRecommendation> _recommendations = [];
  bool _isLoading = false;

  AIProvider() {
    _recommendationService = RecommendationService(_geminiService);
    fetchRecommendations();
  }

  List<AIRecommendation> get recommendations => _recommendations;
  bool get isLoading => _isLoading;

  Future<void> fetchRecommendations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recommendations = await _recommendationService.getAIRecommendations();
    } catch (e) {
      print('AI Provider Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> getChatResponse(String message) async {
    return await _geminiService.askAI(message);
  }
}
