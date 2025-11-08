import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/shared/custom_text.dart';

import '../../../shared/custom_textField.dart';
import '../widgets/custom_btn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController =TextEditingController();
   final GlobalKey<FormState>formKey=GlobalKey<FormState>();
    return GestureDetector(
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
                   child: Column(
                     children: [
                       Gap(10),
                       CustomTextField(
                         controller: emailController,
                         hint: 'Email Address',
                         isPassword: false,),
                       Gap(20),
                       CustomTextField(
                         controller: passwordController,
                         hint: 'Password',
                         isPassword: true,),
                       Gap(40),
                       CustomBtn(text: 'Login',
                         onTap: (){
                           if(formKey.currentState!.validate()){
                             print('success login');
                           }
                         },),
                       Gap(10),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(text: 'Don’t have an account? ',color: Colors.white,),
                           GestureDetector(
                             onTap: ()=>Navigator.push(context,
                                 MaterialPageRoute(builder: (c)=>SignupView())),
                             child: CustomText(text: 'Sign up',color: Colors.white54,
                               fontSize: 16,weight: FontWeight.bold,),
                           ),
                         ],
                       ),
                       Gap(20),
                       GestureDetector(
                         onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (c)=>Root())),
                           child: CustomText(
                             text: 'Continue as a Guest 😋',color: Colors.lightGreenAccent,fontSize: 17,weight: FontWeight.w700,))
                     ],
                   ),
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
