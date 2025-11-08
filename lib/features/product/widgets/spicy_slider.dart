import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
 final double value;
 final ValueChanged<double>onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Image.asset('assets/test/burg.png',height: 250,),
        Spacer(),
        Column(
          children: [
            CustomText(text: 'Customize Your Burger\n to Your Tastes. \nUltimate Experience'),
            Slider(
              min: 0,
                max: 1,
                value: widget.value,
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey.shade400,
                onChanged: widget.onChanged),
            Row(
              children: [
                Text('🥶'),
                Gap(100),
                Text('🌶️')
              ],
            )
          ],
        )
      ],
    );
  }
}
