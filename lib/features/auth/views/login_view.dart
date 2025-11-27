import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_snackbar.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_textField.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final GlobalKey<FormState>formKey=GlobalKey<FormState>();
  bool isLoading=false;
  AuthRepo authRepo=AuthRepo();

  Future<void> login() async {

   if(formKey.currentState!.validate()){
     setState(() =>isLoading=true);
     try {
       final user = await authRepo.login(
         emailController.text.trim(),
         passwordController.text.trim(),
       );
       if (user != null) Navigator.push(context, MaterialPageRoute(builder: (_) =>  Root()));
       setState(() =>isLoading=false);
     } catch (error) {
       setState(() =>isLoading=false);

       ScaffoldMessenger.of(context).showSnackBar(
           CustomSnackBar(error)
       );
     }

   }


  }
  @override
  void initState() {
    emailController.text="sara3@gmail.com";
    passwordController.text="98765432";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(200),
                  SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primaryColor,),
                  Gap(10),
                  CustomText(
                      text: 'Welcome back , Discover The Fast food',
                      color:  Colors.grey.shade600,fontSize: 12, weight: FontWeight.w400,
                      ),
                  Gap(70),
                 Expanded(
                   child: Container(
                     padding: EdgeInsets.all(20),
                     decoration: BoxDecoration(
                         color: AppColors.primaryColor,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(30),
                           topRight: Radius.circular(30),
                         )
                     ),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           Gap(10),
                           CustomTextField(
                             controller: emailController,
                             hint: 'Email Address',
                             style: TextStyle(color: Colors.white),
                             isPassword: false,),
                           Gap(20),
                           CustomTextField(
                             controller: passwordController,
                             hint: 'Password',
                             style: TextStyle(color: Colors.white),
                             isPassword: true,),
                           Gap(40),
                       
                           isLoading?Padding(
                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                             child: CupertinoActivityIndicator(color: Colors.white54,),
                           )
                           :CustomBtn(
                               text: 'Login',
                               onTap: login
                           ),
                           Gap(10),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomText(text: 'Don’t have an account? ',color: Colors.white,),
                               GestureDetector(
                                 onTap: ()=>Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (c)=>SignupView())),
                                 child: CustomText(text: 'Sign up',color: Colors.white54,
                                   fontSize: 16,weight: FontWeight.bold,),
                               ),
                             ],
                           ),
                           Gap(10),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomText(text: 'Just browsing? ',color: Colors.white,),
                               GestureDetector(
                                 onTap: ()=>Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (c)=>Root())),
                                 child: CustomText(text: 'Guest Mode',color: Colors.white54,
                                   fontSize: 14,weight: FontWeight.bold,),
                               ),
                             ],
                           ),

                         ],
                       ),
                     ),
                   ),
                 )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
