import 'package:flutter/material.dart';

import '../../services/ai_service.dart';
import '../../themes/app_colors.dart';

class ResultButton extends StatelessWidget {
  const ResultButton({
    super.key,
    required this.isDark,
    required this.aiService,
    required this.promptController,
    required this.onTap,
  });

  final bool isDark;
  final AiService aiService;
  final TextEditingController promptController;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? AppColors.darkSecondCircleColor
          : AppColors.darkSecondCircleColor,
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: SizedBox(
          height: 35,
          width: 35,
          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
