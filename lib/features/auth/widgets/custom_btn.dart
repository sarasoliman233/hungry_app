import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, this.onTap, required this.text});
final Function()? onTap;
final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Center(child:
          CustomText(
            text: text,
            color: AppColors.primaryColor,
            fontSize: 16,
            weight: FontWeight.w600,))),
    );
  }
}
