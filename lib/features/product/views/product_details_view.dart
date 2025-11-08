import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

import '../widgets/spicy_slider.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value=0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
       leading: GestureDetector(
         onTap: ()=>Navigator.pop(context),
           child: Icon(Icons.arrow_back)),
     ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value:value, onChanged: (v) => setState(() =>value=v)),
              Gap(30),
              CustomText(text: 'Topping',weight: FontWeight.w600,fontSize: 18,color:Color(0xFF3C2F2F)),
              Gap(50),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ToppingCard(
                        image: 'assets/test/tomito.png', title: 'Tomato', onAdd: () {  },),
                    );
                  }),
                ),
              ),
              Gap(40),
              CustomText(text: 'Side Options',weight: FontWeight.w600,fontSize: 18,color: Color(0xFF3C2F2F)),
              Gap(50),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ToppingCard(
                        image: 'assets/test/tomito.png', title: 'Tomato', onAdd: () {  },),
                    );
                  }),
                ),
              ),
              Gap(200)

            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft:  Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 10,
                  offset: Offset(0, 0)
              )
            ]
        ),

        child:   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total',weight: FontWeight.w600,fontSize: 17,color: Color(0xFF808080)),
                  CustomText(text: '\$ 17',weight: FontWeight.w600,fontSize: 28,color: Colors.black),
                ],
              ),

              CustomButton(text: 'Add to cart',onTap: (){},)
            ],
          ),
        ),
      ),
    );
  }
}
