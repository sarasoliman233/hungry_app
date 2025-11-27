import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/network/api_error.dart';
import 'custom_text.dart';

SnackBar CustomSnackBar(e) {
    return SnackBar(
       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
  margin: EdgeInsets.only(bottom: 30,left: 20,right: 20),
  backgroundColor: Colors.red.shade800,
  elevation: 22,
  clipBehavior: Clip.none,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  behavior: SnackBarBehavior.floating,
  content:Row(
  children: [
  Icon(CupertinoIcons.info,color: Colors.white,),
  Gap(15),
  CustomText(text: (e is ApiError ? e.message : 'Unhandled Login error') ,color: Colors.white,fontSize: 13,weight: FontWeight.w600,maxLine: 2,),
  ],
  ));
}