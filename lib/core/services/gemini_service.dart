import 'package:google_generative_ai/google_generative_ai.dart';
import '../contants/gemini_config.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: GeminiConfig.model,
      apiKey: GeminiConfig.apiKey,
    );
  }

  Future<String> askAI(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'I am not sure how to respond to that.';
    } catch (e) {
      return 'Error: $e';
    }
  }
}
