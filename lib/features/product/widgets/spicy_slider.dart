import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged, required this.image, required this.productName});
 final double value;
 final ValueChanged<double>onChanged;
 final String image;
 final String productName;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(5),
        Center(
          child: CustomText(
            text: widget.productName,weight: FontWeight.bold,fontSize:20,
            color:Color(
              0xff0d540d) ,),
        ),

        Gap(15),

        // Image.network(,height: 220,),

        Stack(
            children:[
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: -13,
                  child: Image.asset('assets/shadow.png')),
              Center(
                  child:
                  Image.network(widget.image,width: 220,)),


            ]),
        Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 40),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 15),
                    trackHeight: 4
                ),
                child: Slider(
                    min: 0,
                    max: 1,
                    value: widget.value,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey.shade400,
                    onChanged: widget.onChanged),

            ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cold 🥶'),
                Gap(150),
                Text('Hot 🌶️')
              ],
            )
          ],
        )
      ],
    );
  }
}
