import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/product/views/product_details_view.dart';
import 'package:hungry/shared/custom_text.dart';

import '../widgets/card_item.dart';
import '../widgets/food_category.dart';
import '../widgets/search_field.dart';
import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String>category=[
    'All',
    'Combos',
    'Sliders',
    'Classic'
  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>  FocusScope.of(context).unfocus(),
      child: Scaffold(
       body: CustomScrollView(
        slivers: [

          //AppBAr

         SliverAppBar(
           elevation: 0,
           pinned: true,
           floating: false,
           scrolledUnderElevation: 0,
           backgroundColor: Colors.white,
           toolbarHeight: 170,
           automaticallyImplyLeading: false,
           flexibleSpace: Padding(
               padding: EdgeInsets.only(top: 40,right: 16,left: 16),
             child: Column(
               children: [
                 UserHeader(),
                 Gap(25),
                 SearchField(),
               ],
             ),
           ),

         ),


         SliverToBoxAdapter(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
             child: FoodCategory(selectedIndex: selectedIndex, category:category,),
           ),
         ),



          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 9,
                      (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return ProductDetailsView();
                          }));
                        },
                        child: CardItem(
                          image: 'assets/test/cardImgpng.png',
                          text: 'Cheeseburger',
                          desc: 'Wendy Burger',
                          rate: '4.3',),
                      );
                      }
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                     childAspectRatio: 0.72,
                      crossAxisSpacing: 6,
                    mainAxisSpacing: 10

                  )
              ),

          )

              ],
       ),
      ),
    );
  }
}
