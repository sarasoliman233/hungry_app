import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_button.dart';
import '../widgets/order_details_widget.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

   String selectedMethod='Cash';

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
              CustomText(text: 'Order summary',fontSize: 20,weight: FontWeight.w600,color: Color(0xff3C2F2F),),
              Gap(10),
              OrderDetailsWidget(order: '22', taxes: '3.2', fees: '3', total: '122',),
              Gap(30),
              CustomText(
                text: 'Payment methods',fontSize: 20,weight: FontWeight.w600,color: Color(0xff3C2F2F),),
              Gap(20),
          
              ////Cash
              ListTile(
                onTap: ()=> setState(() => selectedMethod='Cash'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                leading: Image.asset('assets/dollar.png',width: 50,),
                tileColor: Color(0xff3C2F2F),
                title: CustomText(text: 'Cash on Delivery',color: Colors.white,fontSize: 17,),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                    value: 'Cash',
                  groupValue: selectedMethod,
                  onChanged: (v)=> setState(() =>selectedMethod=v!)
                ),
              ),
              Gap(10),
              ////Debit
              ListTile(
                onTap: ()=> setState(() => selectedMethod='Visa'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                leading: Image.asset('assets/visa.png',width: 50,),
                tileColor: Colors.teal.shade200,
                title: CustomText(text: 'Debit card',color: Colors.white,fontSize: 14,),
                subtitle:CustomText(text: '3566 **** **** 0505',color: Colors.white,fontSize: 14,),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Visa',
                  groupValue: selectedMethod,     // دي ويبدا يقارن ويعرف انت ضغطت علي ايه <=(groupValue) هو هنا بيتعرف علي كل ال listTile من خلال ال
                  onChanged: (v)=> setState(() =>selectedMethod=v!)
                  ,
                ),
              ),
              Gap(10),
              
              Row(
                children: [
                  Checkbox(
                    activeColor: Color(0xffEF2A39),
                      value: true,
                      onChanged: (v){}
                  ),
                  CustomText(text: 'Save card details for future payments',color: Color(0xff808080),fontSize: 14,)
                ],
              )
          
          
          
          
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total price',weight: FontWeight.w600,fontSize: 17,color: Color(0xFF808080)),

                  CustomText(text: '\$ 17',weight: FontWeight.w600,fontSize: 28,color: Colors.black),
                ],
              ),

              CustomButton(
                text: 'Pay Now',
                onTap: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 180),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      blurRadius: 7,
                                      offset: Offset(0, 0)
                                  )
                                ]
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(Icons.check,color: Colors.white,size: 40,),
                                ),
                                Gap(10),
                                CustomText(text: 'Success !',fontSize: 25,weight: FontWeight.bold,color: AppColors.primaryColor,),
                                Gap(10),
                                Center(child: CustomText(text: 'Your payment was successful\n A receipt for this purchase \nhas been sent to your email.',fontSize: 12,weight: FontWeight.w400,color: Color(0xffBCBBBB),)),
                                Gap(40),
                                CustomButton(
                                  text: 'Go Back',width: 200,
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },width: 150,)
            ],
          ),
        ),
      ),
    );
  }
}

