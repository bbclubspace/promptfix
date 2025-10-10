import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    super.key,
    required this.isDark,
    required this.onTap
  });

  final bool isDark;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkSecondCircleColor
              : AppColors.darkSecondCircleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.copy,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  }
}