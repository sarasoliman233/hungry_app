import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/home/data/models/Product_model.dart';
import 'package:hungry/features/home/data/repos/product_repo.dart';
import 'package:hungry/features/product/views/product_details_view.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  ProductRepo productRepo =ProductRepo();

  List<ProductModel>? products;

  Future<void>getProducts()async {
    final res = await productRepo.getProducts();
    setState(() {
      products=res;
    });
  }

  @override
  void initState() {
   getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>  FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products==null,
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
             toolbarHeight: 150,
             automaticallyImplyLeading: false,
             flexibleSpace: Padding(
                 padding: EdgeInsets.only(top: 40,right: 16,left: 16),
               child: Column(
                 children: [
                   UserHeader(),
                   Gap(20),
                   SearchField(),
                 ],
               ),
             ),

           ),


          ///Category
           SliverToBoxAdapter(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
               child: FoodCategory(selectedIndex: selectedIndex, category:category,),
             ),
           ),

          ///GridView
           SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: products?.length,
                        (context,index){
                        final product=products![index];

                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (c){
                              return ProductDetailsView(
                                productImage: product.image,
                                productName: product.name,);
                            }));
                          },
                          child: CardItem(
                            image: product.image,
                            text: product.name,
                            desc: product.description,
                            rate: product.rating,),
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
      ),
    );
  }
}
