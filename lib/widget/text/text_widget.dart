import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final bool  isWelcomeText;
  const TextWidget({
    super.key,
    required this.text,
    required this.isDark,
    required this.isWelcomeText,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isDark
            ? AppColors.darkTitleTextColor
            : AppColors.lightTitleTextColor,
        fontSize:isWelcomeText ? 40:25,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
