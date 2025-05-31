import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ai_prompt_duzenleyici/model/ai_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService with ChangeNotifier {
  AiModel aiModel = AiModel();

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

  Future<String?> fetchAiResult(String userMessage) async {
    print("islem başladı");
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    final modelName = dotenv.env['OPENROUTER_MODEL'] ?? "";
    final promptTemplate = dotenv.env['PROMPT_TEMPLATE'] ??"";
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API anahtarı eksik!");
    }

    // Prompt template içindeki değişkenleri doldur
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
              "content": promptContent
            }
          ],
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Hatası: ${response.statusCode}");
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      print("AI Response: $decodedBody");
      aiModel.result = data['choices'][0]['message']['content'];
      aiModel.isResultget=true;
      notifyListeners();
      return aiModel.result;
    } catch (e) {
      print('Hata oluştu: $e');
      return null;
    }
  }
}
