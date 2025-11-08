import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.image, required this.text, required this.desc, this.onMin, this.onAdd, this.onRemove, required this.number});

  final String image,text,desc;
  final Function()? onMin;
  final Function()? onAdd;
  final Function()? onRemove;
  final int number;
  @override
  Widget build(BuildContext context) {
    return   Card(
      color: Colors.white,
      child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(image,height: 102,),
                CustomText(text: text,weight: FontWeight.w600,fontSize: 16,),
                CustomText(text: desc,fontSize: 16,weight: FontWeight.w400,),
              ],
            ),


            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap:onMin,
                      child: CircleAvatar(
                        child: Icon(CupertinoIcons.minus,color: Colors.white,size: 19,),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),

                    Gap(22),
                    CustomText(text: number.toString(),weight: FontWeight.w600,fontSize: 18,),

                    Gap(22),
                    GestureDetector(
                      onTap:onAdd,
                      child: CircleAvatar(
                        child: Icon(CupertinoIcons.add,color: Colors.white,size: 19,),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Gap(33),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    height: 43,
                    width: 154,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: CustomText(text: 'Remove',color: Colors.white,fontSize: 14,weight: FontWeight.w600,)),
                  ),
                )

              ],
            ) ,



          ],
        ),
      ),

    );
  }
}
