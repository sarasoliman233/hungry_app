import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo{

  final ApiService apiService=ApiService();
  UserModel? _currentUser;
  bool isGuest=false;

  ///login
 Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        if (code != 200  && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final user = UserModel.fromJson(data);

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest=false;
        _currentUser=user;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    }on DioError catch(e){
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
    }


  ///SignUp
Future<UserModel?>SignUp(String name,String email, String password)async{
    
    try {
      final response=await apiService.post('/register',
        {
          "name":name,
          "email":email,
          "password":password
        });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder=int.tryParse(code);
        final data = response['data'];

        if (coder != 200  && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown Error');
        }

        final user = UserModel.fromJson(data);

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;

      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }


    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch(e){
      throw ApiError(message: e.toString());
    }

    
}


   ///GetProfile
Future<UserModel?>getProfileData()async{
    try {

      final token=await PrefHelper.getToken();
      if(token ==null || token=='guest'){
         return null;
      }

      final response=await apiService.get('/profile');
      final user=UserModel.fromJson(response['data']);
      _currentUser=user;

      return user;


    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
}


    ///update profile
Future<UserModel?>updateProfileData({
 required String name,
 required String email,
 required String address,
  String? visa,
  String? imagePath,
})
async{
    try{
      final formData=FormData.fromMap({
        "name":name,
        "email":email,
        "address":address,
       if(visa !=null && visa.isNotEmpty) "Visa":visa,
       if(imagePath !=null &&imagePath.isNotEmpty) "image":await MultipartFile.fromFile(imagePath,filename: "profile.jpg"),
      });

      final response=await apiService.post('/update-profile', formData,);

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data =response['data'];
        final coder = int.tryParse(code);


        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown Error');
        }

        final updatedUser=UserModel.fromJson(data);
        _currentUser=updatedUser;
        
        return updatedUser;
      }else{
        throw ApiError(message:"Invalid Error from here");
      }


    }on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch(e){
      throw ApiError(message: e.toString());
    }
}


   ///Logout
Future<void>logout()async{
    final response=await apiService.post('/logout', {});
    if(response['data'] !=null){
      throw ApiError(message: "Error in Logout");
    }
    PrefHelper.clearToken();
    _currentUser=null;
    isGuest=true;
}

/// auto Login

Future<UserModel?>autoLogin()async{
  final token = await PrefHelper.getToken();
 // print('🔑 Token from storage: ${token ?? 'null'}');

  if (token == null || token == 'guest') {
    isGuest = true;
    _currentUser = null;
    return null;
  }
  isGuest = false;
  try {
    final user = await getProfileData();
    _currentUser = user;
    return user;
  } catch (e) {
    await PrefHelper.clearToken();
    isGuest = true;
    _currentUser = null;
    return null;
  }
}

/// continue as a guest

Future<void>continueAsGuest()async{
   isGuest=true;
   _currentUser=null;

await   PrefHelper.saveToken('guest');

}


  UserModel? get currentUser => _currentUser;           //بعمل جيتر منه عشان اقدر استخدمه خارج الكلاس

  bool get isLoggedIn => !isGuest && _currentUser != null;


}