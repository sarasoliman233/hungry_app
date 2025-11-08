import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap, this.width, this.color, this.height});

  final String text;
  final Function()? onTap;
  final double? width;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
          height: height ?? 50,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
          decoration: BoxDecoration(
              color: color ?? AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(child: CustomText(text: text,weight: FontWeight.w600,fontSize: 15,color: Colors.white))),
    );
  }
}
