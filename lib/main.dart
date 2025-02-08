// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/view/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'controller/app_fontsize_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite for desktop platforms
  if (!Platform.isAndroid && !Platform.isIOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Initialize the SliderController and load saved value
  final SliderController sliderController = Get.put(SliderController());
  sliderController.loadFontSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(320, 600),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Demo App ',
          theme: ThemeData(
            primaryColor: AppColor.primaryColor,
            primarySwatch: Colors.blue,
        
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 16.sp), // Default size
              bodyMedium: TextStyle(fontSize: 14.sp),
            ),
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
