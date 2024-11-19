// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/view/home_screen.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        // fontFamily: "SourGummy",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      home: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => HomeScreen(),
      ),
    );
  }
}
