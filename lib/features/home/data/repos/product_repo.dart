

import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/home/data/models/Product_model.dart';
import 'package:hungry/features/home/data/models/side_options_model.dart';
import 'package:hungry/features/home/data/models/topping_model.dart';

class ProductRepo{

 ApiService _apiService=ApiService();

 ///get products
 Future<List<ProductModel>>getProducts()async{

   try {
     final response=await _apiService.get("/products/");

     return (response["data"] as List)
         .map((e)=>ProductModel.fromJson(e))
         .toList();
   }  catch (e) {
     print(e.toString());
     return [];

   }

 }


 ///get Toppings
Future<List<ToppingModel>>getTopping()async{

   try {
     final response=await _apiService.get("/toppings");
     return (response["data"] as List)
         .map((topping)=>ToppingModel.fromJson(topping)).toList();
   }  catch (e) {
     print(e.toString());
     return [];
   }

}

///get side options

Future<List<ToppingModel>>getSideOptions()async{
  try {
    final response=await _apiService.get("/side-options");
    return (response["data"] as List)
        .map((topping)=>ToppingModel.fromJson(topping)).toList();
  }  catch (e) {
    print(e.toString());
    return [];
  }
}


}