import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/features/home/views/home_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash.dart';

import 'features/auth/views/signup_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations( //// دي عشان لو حاول اليوزر يلف الموبايل الديزاين يبقا ثابت دائما
   [ DeviceOrientation.portraitUp,]
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry App',
      theme: ThemeData(
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white
      ),
      home: SplashView(),
    );
  }
}

