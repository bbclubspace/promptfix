import 'package:promptfix/themes/app_colors.dart';
import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class Change extends StatelessWidget {
  final AiService aiService;
  final bool isDark;

  const Change({
    required this.aiService,
    required this.isDark,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguageBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.lightSubContainerActiveColor:AppColors.lightSubContainerPasiveColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          aiService.aiModel.language,
          style: TextStyle(
            color: isDark
                ?Colors.white : Colors.black,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    String currentLanguage = aiService.aiModel.language;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Lütfen bir dil seçin:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildLanguageOption(context, 'Türkçe', currentLanguage),
              _buildLanguageOption(context, 'English', currentLanguage),
              _buildLanguageOption(context, 'Español', currentLanguage),
              // İstediğin kadar dil ekleyebilirsin
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String language, String currentLanguage) {
    bool isSelected = language == currentLanguage;

    return GestureDetector(
      onTap: () {
        aiService.updateLanguage(language);
        Navigator.pop(context); // Paneli kapat
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightSubContainerActiveColor:AppColors.lightSubContainerPasiveColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          language,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
