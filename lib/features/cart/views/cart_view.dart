import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/checkout/views/checkout_view.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_button.dart';
import '../widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

   final int itemCount=3;
  late List<int> quantities;

  @override
  void initState() {
    quantities=List.generate(itemCount, (_)=>1);
    super.initState();
  }
  void onAdd(int index){
    setState(() {
      quantities[index] ++;
    });
  }

   void onMin(int index){
     setState(() {
       if(quantities[index]>1){
         quantities[index] --;
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:  ListView.builder(
          padding: EdgeInsets.only(bottom: 120,top: 10),
                itemCount: itemCount,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CartItem(
                      image: 'assets/test/cardImgpng.png',
                      text: 'Hamburger', desc: 'Veggie Burger',
                      number: quantities[index],
                      onAdd: () => onAdd(index),
                      onMin: () => onMin(index),
                    ),
                  );
                }),
              ),



      bottomSheet:  Container(
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
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Total',weight: FontWeight.bold,fontSize: 17,color: Color(0xFF3C2F2F)),
                CustomText(text: '\$17',weight: FontWeight.w600,fontSize: 28,color: Colors.black),
              ],
            ),

             CustomButton(text: 'Checkout',
               width: 150,
               onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context){
                 return CheckoutView();
               }));

               },)
          ],
        ),
      ),
    );
  }
}
