import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:promptfix/model/ai_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiService with ChangeNotifier {
  AiModel aiModel = AiModel();
  int adsCounter = 0;

  void updatePrompt(String prompt) {
    aiModel.prompt = prompt;
    notifyListeners();
  }

  void updateLanguage(String language) {
    aiModel.language = language;
    notifyListeners();
  }

  void selectContentType(ContentType contentType) {
    //kod,görsel,yazı
    aiModel.selectContentType(contentType);
    notifyListeners();
  }

  void updateAdsCounter() {
    adsCounter = adsCounter + 1;
    saveAdsCounter();
    notifyListeners();
  }

  void resetAdsCounter() {
    adsCounter = 0;
    saveAdsCounter();
    notifyListeners();
  }

  Future<void> saveAdsCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('adsCounter', adsCounter);
  }

  Future<void> loadAdsCounter() async {
    final prefs = await SharedPreferences.getInstance();
    adsCounter = prefs.getInt('adsCounter') ?? 0;
    notifyListeners();
  }

  Future<String?> fetchAiResult(String userMessage) async {
    debugPrint("islem başladı");

    updateAdsCounter();
    if (adsCounter == 5) resetAdsCounter();

    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    final modelName = dotenv.env['OPENROUTER_MODEL'] ?? "";
    final promptTemplate = dotenv.env['PROMPT_TEMPLATE'] ?? "";
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API anahtarı eksik!");
    }

    final promptContent = promptTemplate
        .replaceAll('{language}', aiModel.language)
        .replaceAll('{contentType}', aiModel.selectedContentType.toString())
        .replaceAll('{prompt}', userMessage);

    try {
      final response = await http.post(
        Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": modelName,
          "messages": [
            {
              "role": "user",
              "content": [
                {"type": "text", "text": promptContent}
              ]
            }
          ]
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Hatası: ${response.statusCode}");
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      debugPrint("AI Response: $decodedBody");
      aiModel.result = data['choices'][0]['message']['content'];
      aiModel.isResultget = true;
      notifyListeners();
      return aiModel.result;
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      return null;
    }
  }
}
