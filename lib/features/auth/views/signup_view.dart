import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/root.dart';

import '../../../shared/custom_snackbar.dart';
import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../widgets/custom_btn.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override


  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();
  final GlobalKey<FormState>formKey=GlobalKey<FormState>();

  bool isLoading=false;
  AuthRepo authRepo=AuthRepo();

  Future<void>signUp()async{
    if(formKey.currentState!.validate()){

      try {
        setState(() =>isLoading=true);
        final user=await authRepo.SignUp(
            nameController.text.trim(),
            emailController.text.trim(),
            passController.text.trim());

        if(user !=null){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginView()));
        }
        setState(() =>isLoading=false);
      }  catch (error) {
        setState(() =>isLoading=false);

        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(error)
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(200),
                  SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primaryColor,),
                  Gap(10),
                  CustomText(text: 'Welcome back to food app – your favorite meals await!',
                    color: Colors.grey.shade600,fontSize: 12,
                  ),
                  Gap(70),
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                       color: AppColors.primaryColor,
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(30),
                         topRight: Radius.circular(30),
                       )
                     ),
                     padding: EdgeInsets.all(20),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           Gap(10),
                           CustomTextField(
                             controller: nameController,
                             hint: 'Name',
                             style: TextStyle(color: Colors.white),
                             isPassword: false,),
                           Gap(20),
                           CustomTextField(
                             controller: emailController,
                             hint: 'Email Address',
                             style: TextStyle(color: Colors.white),
                             isPassword: false,),
                           Gap(20),
                           CustomTextField(
                             style: TextStyle(color: Colors.white),
                             controller: passController,
                             hint: 'Password',
                             isPassword: true,),
                           Gap(40),

                           isLoading?Padding(
                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                             child: CupertinoActivityIndicator(color: Colors.white54,),
                           )
                           :CustomBtn(text: 'Sign Up',
                             onTap: signUp
                           ),
                           Gap(10),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomText(text: 'Already have an account? ',color: Colors.white,),
                               GestureDetector(
                                 onTap: ()=>Navigator.pushReplacement(context,
                                     MaterialPageRoute(builder: (c)=>LoginView())),
                                 child: CustomText(text: 'Log In',color: Colors.white54,
                                   fontSize: 16,weight: FontWeight.bold,),
                               ),
                             ],
                           )
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
