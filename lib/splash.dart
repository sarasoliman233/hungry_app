import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/root.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'root.dart'; // تأكدي من اسم الصفحة اللي بتروحي ليها

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _imageController;
  late Animation<double> _logoAnimation;
  late Animation<double> _imageAnimation;

  AuthRepo authRepo=AuthRepo();

  Future<void>_checkLogin()async{
    try {
     final user=await authRepo.autoLogin();
      if(!mounted)return;
      if(authRepo.isGuest){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Root()));
      }else if(user!=null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Root()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginView()));
      }
    }catch (e) {
     print('Error from splash:${e.toString()}');
    }

  }

  @override
  void initState() {
    super.initState();

    // Animation for logo
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOut,
    );

    // Animation for bottom image
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _imageAnimation = CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    );

    // Start animations sequentially
    _logoController.forward().then((_) {
      _imageController.forward();
    });

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3),  _checkLogin);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const Gap(280),
            FadeTransition(
              opacity: _logoAnimation,
              child: ScaleTransition(
                scale: _logoAnimation,
                child: SvgPicture.asset('assets/logo/logo.svg'),
              ),
            ),
            const Spacer(),
            FadeTransition(
              opacity: _imageAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(_imageAnimation),
                child: Image.asset('assets/splash/splash.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
