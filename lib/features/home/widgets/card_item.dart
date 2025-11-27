import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.image, required this.text, required this.desc, required this.rate});

  final String image,text,desc,rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                children:[
                  Positioned(
                      right: 0,
                      left: 0,
                      bottom: -5,
                      child: Image.asset('assets/shadow.png')),
                  Center(
                      child:
                      Image.network(image,width: 100,)),


                ]),
            Gap(10),
            CustomText(
              text:text,weight: FontWeight.w600,fontSize: 13.5,),
            Gap(4),
            CustomText(
              text:desc,weight: FontWeight.w400,fontSize: 12,),
            Spacer(),
            Row(
              children: [
                Image.asset('assets/star.png',width: 16,),
                Gap(5),
                CustomText(
                  text:rate,weight: FontWeight.w500,fontSize: 16,),
                Spacer(),
                Icon(CupertinoIcons.heart_fill,color: AppColors.primaryColor,)
              ],
            ),
            Gap(5),
          ],
        ),
      ),
    );
  }
}
