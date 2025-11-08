import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';

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

@override
  void initState() {
   _name.text='Sara Soliman';
   _email.text='sarasoliman@gmail.com';
   _address.text='Egypt,mansoura';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.primaryColor,
      appBar: AppBar(
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
          child: Column(
            children: [
          
              Center(
                child: Container(
                  height: 129,
                  width: 126,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.shutterstock.com/image-vector/black-woman-smiling-portrait-vector-600nw-2281497689.jpg')),
                    color: Colors.grey,
                    border: Border.all(width: 4,color: Colors.white),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
              Gap(40),
              CustomUserTxtField(label: 'Name', controller: _name,),
              Gap(30),
              CustomUserTxtField(label: 'Email', controller: _email,),
              Gap(30),
              CustomUserTxtField(label: 'Address', controller: _address,),
              Gap(10),
              Divider(thickness: 1.7,endIndent: 25,indent: 25,),
              Gap(10),
          
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                leading: Image.asset('assets/visa.png',width: 50,),
                tileColor: Color(0xffF3F4F6),
                title: CustomText(text: 'Debit card',color: Color(0xff3C2F2F),fontSize: 14,weight: FontWeight.w500,),
                subtitle:CustomText(text: '3566 **** **** 0505',color: Color(0xff808080),fontSize: 14,weight: FontWeight.w500,),
                trailing: CustomText(text: 'Default',color: Colors.teal,fontSize: 13,),
          
                ),
              Gap(300)
          
          
            ],
          
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 27,vertical: 15),
                
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Edit Profile',color:Colors.white,),
                    Gap(15),
                    Image.asset('assets/editIcon.png',color: Colors.white,width: 18,)
                  ],
                ),
              ),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 27,vertical: 11),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryColor)
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Edit Profile',color:AppColors.primaryColor),
                    Gap(15),
                    Icon(Icons.exit_to_app,color: AppColors.primaryColor,)
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
