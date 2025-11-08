import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
   FoodCategory({super.key,required this.selectedIndex,required this.category});

 final List category;
 final int selectedIndex;

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
late int selectedIndex;

@override
  void initState() {
    selectedIndex=widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            widget.category.length, (index){
          return  GestureDetector(
            onTap: (){
              setState(() {
               selectedIndex=index;
                print(index);
              });
            }
            ,
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.symmetric(horizontal: 27,vertical: 13),
              decoration: BoxDecoration(
                  color:selectedIndex==index? AppColors.primaryColor : Color(0xffF3F4F6),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: CustomText(
                text: widget.category[index],weight: FontWeight.w600,color: selectedIndex==index ? Colors.white : Color(0xff6A6A6A),),
            ),
          );
        }),
      ),
    );
  }
}
