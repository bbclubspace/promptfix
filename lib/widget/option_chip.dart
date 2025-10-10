import 'package:promptfix/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:promptfix/model/ai_model.dart';
import '../services/ai_service.dart';

class OptionChip extends StatelessWidget {
  final String label;
  final ContentType contentType;
  final AiService aiService;

  const OptionChip({
    required this.label,
    required this.contentType,
    required this.aiService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = aiService.aiModel.selectedContentType == contentType;

    return GestureDetector(
      onTap: () {
        aiService.selectContentType(contentType);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightSubContainerActiveColor:AppColors.lightSubContainerPasiveColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
