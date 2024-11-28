// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



import 'package:quran/view/home_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import the sqflite_common_ffi package


void main() async {
 // Initialize the databaseFactory for ffi (desktop platforms)
 
  databaseFactory = databaseFactoryFfi; // Set the databaseFactory to ffi
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: "SourGummy",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) => HomeScreen(),
      ),
    );
  }
}
