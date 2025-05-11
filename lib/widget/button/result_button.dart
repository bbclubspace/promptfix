import 'package:flutter/material.dart';

import '../../services/ai_service.dart';
import '../../themes/app_colors.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({
    super.key,
    required this.isDark,
    required this.aiService,
    required this.promptController,
  });

  final bool isDark;
  final AiService aiService;
  final TextEditingController promptController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSecondCircleColor
            : AppColors.darkSecondCircleColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(onPressed: (){aiService.fetchAiResult(promptController.text);}, icon: const Icon(Icons.arrow_forward,
          color: Colors.white, size: 20),)
    );
  }
}