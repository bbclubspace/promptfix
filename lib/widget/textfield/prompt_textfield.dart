import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class PromptTextField extends StatelessWidget {
  const PromptTextField({
    super.key,
    required this.promptController,
    required this.isDark,
  });

  final TextEditingController promptController;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: promptController,
        decoration: const InputDecoration(
          hintText: "Promptunu gir",
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: isDark
              ? AppColors.darkPromptTextColor
              : AppColors.lightPromptTextColor,
        ),
      ),
    );
  }
}