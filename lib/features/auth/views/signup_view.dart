import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/views/login_view.dart';

import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../widgets/custom_btn.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override

  Widget build(BuildContext context) {
    TextEditingController nameController =TextEditingController();
    TextEditingController emailController =TextEditingController();
    TextEditingController passController =TextEditingController();
   // TextEditingController confirmPassController =TextEditingController();

   final GlobalKey<FormState>formKey=GlobalKey<FormState>();
    return Scaffold(
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
                         isPassword: false,),
                       Gap(20),
                       CustomTextField(
                         controller: emailController,
                         hint: 'Email Address',
                         isPassword: false,),
                       Gap(20),
                       CustomTextField(
                         controller: passController,
                         hint: 'Password',
                         isPassword: true,),
                       Gap(40),
                       CustomBtn(text: 'Sign Up',
                         onTap: (){
                           if(formKey.currentState!.validate()){
                             print('success register');
                           }
                         },
                       ),
                       Gap(10),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(text: 'Already have an account? ',color: Colors.white,),
                           GestureDetector(
                             onTap: ()=>Navigator.push(context,
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
    );
  }
}
