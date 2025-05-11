import 'package:flutter/material.dart';

import '../../services/themes_service.dart';
import '../../themes/app_colors.dart';

class ChangeThemeModeButton extends StatelessWidget {
  const ChangeThemeModeButton({
    super.key,
    required this.themeService,
    required this.isDark,
  });

  final ThemeService themeService;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: themeService.toggleTheme,
      child: Container(
        height: 43,
        width: 43,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkFirstCircleColor
              : AppColors.lightFirstCircleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isDark
            ? Image.asset('assets/sun.png')
            : Image.asset("assets/moon.png"),
      ),
    );
  }
}