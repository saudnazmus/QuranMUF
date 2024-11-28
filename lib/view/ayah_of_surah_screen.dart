import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/ayah_of_surah_controller.dart';

class SurahAyatView extends StatelessWidget {
  const SurahAyatView(
      {super.key, required this.surahNumber, required this.surahName});
  final int surahNumber;
  final String surahName;
  @override
  Widget build(BuildContext context) {
    final SurahAyatController controller =
        Get.put(SurahAyatController(surahId: surahNumber));
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: SpinKitWaveSpinner(
              color: Colors.grey,
              waveColor: Colors.green,
              trackColor: Colors.green,
            ),
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            itemCount: controller.allSurahList.length,
            itemBuilder: (context, index) {
              final ayat = controller.allSurahList[index];
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.indexTextColor,
                  boxShadow: listTileShadow,
                  // border: Border.all(
                  //   color: AppColor.primaryColor,
                  // ),
                ),
                margin: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 6.h, top: 6.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              minWidth: 30.w,
                              minHeight: 30.w,
                            ),
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              // borderRadius: BorderRadius.circular(10.r),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(ayat.ayetNumber.toString(),
                                    style: TextStyle(
                                        color: AppColor.indexTextColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          horizontalGap(10.w),
                          Expanded(
                            child: Text(
                              textDirection: TextDirection.rtl,
                              ayat.ayatArabic,
                              style: TextStyle(
                                  color: AppColor.primaryTextColorForTitle,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                    verticalGap(5.h),
                    Text(
                      textDirection: TextDirection.ltr,
                      ayat.ayatBangla.toString(),
                      style: TextStyle(
                          color: AppColor.primaryTextColorForTitle,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
