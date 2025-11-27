import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/spicy_slider.dart';
import '../widgets/topping_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key,  required this.productImage, required this.productName});
  final String productImage;
  final String productName;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value=0.8;

  ProductRepo productRepo=ProductRepo();

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;

Future<void>getToppings()async{
  final res=await productRepo.getTopping();
  setState(() {
    toppings=res;
  });
}

  Future<void>getOptions()async{
    final res=await productRepo.getSideOptions();
    setState(() {
      options=res;
    });
  }



  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.productImage.isEmpty ||toppings==null ,
      child: Scaffold(
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
                  productName: widget.productName,
                  image: widget.productImage,
                  value:value, onChanged: (v) => setState(() =>value=v)
                ),

                Gap(30),
                CustomText(text: 'Topping',weight: FontWeight.w600,fontSize: 18,color:Color(0xFF3C2F2F)),
                Gap(50),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 4, (index){
                      final topping=toppings?[index];
                      if(topping ==null){
                        return CupertinoActivityIndicator();
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ToppingCard(
                          image: topping.image,
                          title: topping.name, onAdd: () {  },),
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
                    children: List.generate(options?.length ?? 5, (index){
                      final sideOptions=options?[index];
                      if(sideOptions==null){
                        return CupertinoActivityIndicator();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ToppingCard(
                          image: sideOptions.image,
                          title: sideOptions.name, onAdd: () {  },),
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
      ),
    );
  }
}
