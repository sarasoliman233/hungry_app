import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(15),
      child: TextField(

        cursorColor: AppColors.primaryColor,
        cursorHeight: 17,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 6,   // قللي الرقم ده على مزاجك
            horizontal: 10,
          ),

          hintText: 'Search..',
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
          prefixIcon: Icon(CupertinoIcons.search,size: 19,),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)
          ),
        ),
      ),
    );
  }
}
