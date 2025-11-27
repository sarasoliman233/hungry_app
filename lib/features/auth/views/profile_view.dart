import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/custom_text.dart';
import '../widgets/customUserTxtField.dart';

class ProfileView extends StatefulWidget {
   ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

 final TextEditingController _name=TextEditingController();
 final TextEditingController _email=TextEditingController();
 final TextEditingController _address=TextEditingController();
 final TextEditingController _visa=TextEditingController();

 UserModel? userModel;
 AuthRepo authRepo=AuthRepo();
 String? selectedImage;
 bool isLoading=false;
 bool logOutLoading=false;
 bool isGuest=false;

 //GetProfile
 Future<void>getProfileData()async{
  try{

    final user=await authRepo.getProfileData();
    setState(() {
      userModel=user;
    });
  }catch(e){

    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(e));
  }
 }

 //PickImage
 Future<void>pickImage()async{
   final pickedImage=await ImagePicker().pickImage(source: ImageSource.gallery);
   if(pickedImage !=null){
     setState(() {
       selectedImage=pickedImage.path;
     });
   }
 }

 //UpdateProfile
 Future<void>updateProfile()async{
   try{
   setState(() =>isLoading=true);
   final user=await authRepo.updateProfileData(
    name: _name.text.trim(),
    email: _email.text.trim(),
    address: _address.text.trim(),
    imagePath:selectedImage ,
    visa:_visa.text.trim() ,
);
   ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar("Profile Updated Successfully"));
   setState(() =>isLoading=false);
   setState(() => userModel=user);
   await getProfileData();
   }catch (e) {
     setState(() =>isLoading=false);
     String errorMsg="Failed to update profile";
     if(e is ApiError) {
       errorMsg = e.message;
       print(errorMsg);
     };

   }
 }

 //logout
 Future<void>logout() async {
  setState(() => logOutLoading=true);
  await authRepo.logout();
  setState(() => logOutLoading=false);
  await Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>LoginView()));
 }

 Future<void>autoLogin()async{
   final user=await authRepo.autoLogin();
   setState(() =>isGuest=authRepo.isGuest);
   if(user !=null) setState(() => userModel=user);
 }

@override
  void initState() {
   autoLogin();
  getProfileData().then((v) {
    _name.text = userModel?.name.toString() ?? 'Sara';
    _email.text = userModel?.email.toString() ?? 'Sara@gmail.com';
    _address.text =
    userModel?.address == null || userModel!.address!.isEmpty ? "Egypt" : userModel!.address!;
  });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   if(!isGuest){
     return RefreshIndicator(
       backgroundColor: Colors.white70,
       displacement: 50,
       color: AppColors.primaryColor,
       onRefresh: ()async{
         await  getProfileData();
       },
       child: GestureDetector(
         onTap: ()=> FocusScope.of(context).unfocus(),
         child: Scaffold(
           backgroundColor:  AppColors.primaryColor,
           appBar: AppBar(
             scrolledUnderElevation: 0,
             backgroundColor:  AppColors.primaryColor,
             leading: GestureDetector(
                 onTap: ()=>Navigator.pop(context),
                 child: Icon(Icons.arrow_back,color: Colors.white,)),
             actions: [

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
                 child: SvgPicture.asset('assets/settings.svg',width: 24,),
               )
             ],
           ),

           body: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15.0),
             child: SingleChildScrollView(
               child: Skeletonizer(
                 enabled: userModel==null ,
                 child: Column(
                   children: [

                     //image
                     Center(
                         child: Padding(
                             padding: const EdgeInsets.all(1),
                             child: Container(
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white,
                               ),
                               padding: const EdgeInsets.all(3),
                               child: Container(
                                 height: 100,
                                 width: 100,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   border: Border.all(
                                     width: 1,
                                     color: Colors.white,
                                   ),
                                   color: Colors.grey.shade100,
                                 ),
                                 clipBehavior: Clip.antiAlias,
                                 child: selectedImage != null
                                     ? Image.file(File(selectedImage!), fit: BoxFit.cover)
                                     : (userModel?.image != null && userModel!.image!.isNotEmpty)
                                     ? Image.network(userModel!.image!, fit: BoxFit.cover, errorBuilder: (context, err, builder) => Icon(Icons.person),)
                                     : Icon(Icons.person),
                               ),
                             ))),

                     Gap(10),
                     GestureDetector(
                       onTap: pickImage,
                       child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(14),
                             color: Colors.white38,
                           ),
                           child: CustomText(text: 'Upload Image',color: Colors.white,fontSize: 14,weight: FontWeight.w800,)),
                     ),


                     Gap(40),
                     CustomUserTxtField(label: 'Name', controller: _name, keyboardType: TextInputType.name,),
                     Gap(30),
                     CustomUserTxtField(label: 'Email', controller: _email, keyboardType: TextInputType.emailAddress,),
                     Gap(30),
                     CustomUserTxtField(label: 'Address', controller: _address,keyboardType: TextInputType.streetAddress,),
                     Gap(10),
                     Divider(thickness: 1.7,endIndent: 25,indent: 25,),
                     Gap(10),

                     userModel?.visa == null || userModel!.visa!.isEmpty
                         ? CustomUserTxtField(
                       label: 'ADD VISA CARD', controller: _visa,keyboardType: TextInputType.number,)
                         :ListTile(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(18)
                       ),
                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
                       leading: Image.asset('assets/visa.png',width: 50,),
                       tileColor: Color(0xffF3F4F6),
                       title: CustomText(text: 'Debit card',color: Color(0xff3C2F2F),fontSize: 14,weight: FontWeight.w500,),
                       subtitle:CustomText(text: userModel?.visa ??'**** **** 6473',color: Color(0xff808080),fontSize: 14,weight: FontWeight.w500,),
                       trailing: CustomText(text: 'Default',color: Colors.teal,fontSize: 13,),

                     ),

                     Gap(300)
                   ],

                 ),
               ),
             ),
           ),


           bottomSheet: Container(
             height: 66,
             decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(color: Colors.grey.shade700,blurRadius: 8)
                 ]
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 12.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   //edit
                   GestureDetector(
                     onTap: updateProfile,
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 27,vertical: 15),

                       decoration: BoxDecoration(
                           color: AppColors.primaryColor,
                           borderRadius: BorderRadius.circular(12)
                       ),
                       child:
                       isLoading
                           ?Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 40.0),
                         child: CupertinoActivityIndicator(color: Colors.white38,),
                       )
                           :Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(text: 'Edit Profile',color:Colors.white,),
                           Gap(15),
                           Image.asset('assets/editIcon.png',color: Colors.white,width: 18,)
                         ],
                       ),
                     ),
                   ),

                   Gap(10),

                   GestureDetector(
                     onTap:logout,
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 27,vertical: 11),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(color: AppColors.primaryColor)
                       ),
                       child:
                       logOutLoading
                           ?Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 40.0),
                         child: CupertinoActivityIndicator(color: Colors.black12,),
                       )
                           :Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(text: 'Log Out',color:AppColors.primaryColor),
                           Gap(15),
                           Icon(Icons.exit_to_app,color: AppColors.primaryColor,)
                         ],
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
   }else if(isGuest){
     return Center(child:
     Padding(
       padding: const EdgeInsets.all(24.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Center(child: CustomText(text: "You're a guest! Create an account to complete your profile",
             fontSize: 15,

           )),
           Gap(50),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (c)=>SignupView()));
             },
             child: CustomButton(
                 text: 'Create Account',
                 width: 200,
                 height: 50,
             ),
           )
         ],
       ),
     ));
   }
   return SizedBox();
  }
}
