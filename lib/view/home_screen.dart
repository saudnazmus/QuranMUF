import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/view/all_surah_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Muslim Ummah',
            style: TextStyle(
              color: AppColor.primaryTextColorForTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  size: 25.sp,
                  color: AppColor.primaryTextColorForTitle,
                )),
            horizontalGap(2.w),
          ],
        ),
        drawer: const Drawer(),
        body: const SafeArea(child: AllSurahListScreen()));
  }
}
