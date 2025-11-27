import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService{

final DioClient _dioClient=DioClient();

///CRUD Methods


///Get
 Future<dynamic>get(String endPoints)async{
   
   try {
     final response=await _dioClient.dio.get(endPoints);   //هنا ببعت ال endPoints بس عشان هو فاهم من خلال ال Dio انه عباره عن ال baseUrl+endPoints
     return response.data;                                 //عشان عملناها في كلاس DioClient وبياخد حاجه اسمهاbaseUrl
   } on DioError catch (e) {
     return ApiExceptions.handleError(e);
   }

 }
  
 
///Post

Future<dynamic>post(String endPoints,dynamic body)async{

  try {
    final response=await _dioClient.dio.post(endPoints,data: body);
    return response.data;
  } on DioError catch (e) {
    return ApiExceptions.handleError(e);
  }

}


///Put || Update


Future<dynamic>put(String endPoints,dynamic body)async{

  try {
    final response=await _dioClient.dio.put(endPoints,data: body);
    return response.data;
  } on DioError catch (e) {
    return ApiExceptions.handleError(e);
  }

}


///Delete

Future<dynamic>delete(String endPoints,dynamic body)async{

  try {
    final response=await _dioClient.dio.delete(endPoints,data: body);
    return response.data;
  } on DioError catch (e) {
    return ApiExceptions.handleError(e);
  }

}

}