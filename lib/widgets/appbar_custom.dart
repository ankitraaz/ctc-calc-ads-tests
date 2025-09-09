import 'package:ctc_calc/theme/app_text_style.dart';
import 'package:ctc_calc/theme/appcolor.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.cardBackground,
        child: Text("CTC Calculator", style: AppTextStyles.appBarTitle),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
