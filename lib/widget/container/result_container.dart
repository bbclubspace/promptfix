import 'package:flutter/material.dart';
import '../../services/ai_service.dart';
import '../../themes/app_colors.dart';
import '../button/copy_button.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.isDark,
    required this.aiService,
  });

  final bool isDark;
  final AiService aiService;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkContainerColor
            : AppColors.lightContainerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              aiService.aiModel.result,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
          ),
          CopyButton(isDark: isDark),
        ],
      ),
    );
  }
}