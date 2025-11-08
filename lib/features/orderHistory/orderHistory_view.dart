import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/shared/custom_button.dart';

import '../../shared/custom_text.dart';
import '../cart/widgets/cart_item.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:  ListView.builder(
            padding: EdgeInsets.only(bottom: 120,top: 10),
            itemCount: 3,
            itemBuilder: (context,index){
              return  Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/test/cardImgpng.png',height: 102,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "Hamburger",weight: FontWeight.w600,fontSize: 16,),
                              CustomText(text: 'Qy : 3X',fontSize: 16,weight: FontWeight.w400,),
                              CustomText(text: 'Price : 20\$',fontSize: 16,weight: FontWeight.w400,),

                            ],
                          )

                        ],
                      ),
                      Gap(20),

                      CustomButton(text: 'Order Again',
                        width: double.infinity,
                        color: Colors.grey.shade500,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
