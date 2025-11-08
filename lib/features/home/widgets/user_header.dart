import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            SvgPicture.asset('assets/logo/logo.svg',color: AppColors.primaryColor,height: 35,),
            Gap(5),
            CustomText(text: 'Hello , Sara Soliman',fontSize: 16,weight: FontWeight.w500,color: Colors.grey.shade500,)
          ],
        ),
        Spacer(),
        CircleAvatar(radius: 32,child: Icon(Icons.person,color: Colors.white,),backgroundColor: AppColors.primaryColor)
      ],
    );
  }
}
