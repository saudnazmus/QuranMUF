import 'package:flutter/material.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/view/all_surah_list_screen.dart';
import 'package:quran/widget/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'MUF Quran',
            style: TextStyle(
              color: AppColor.primaryTextColorForTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const MyCustomDrawer(),
        body: const SafeArea(child: AllSurahListScreen()));
  }
}
