import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/all_surah_list_controller.dart';
import 'package:quran/controller/app_fontsize_controller.dart';
import 'package:quran/view/ayah_of_surah_screen.dart';

class AllSurahListScreen extends StatelessWidget {
  const AllSurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllSurahListController surahController = Get.put(AllSurahListController());
    final SliderController sliderController = Get.find<SliderController>();

    return Obx(() {
      if (surahController.isLoading.value) {
        return Center(
          child: SpinKitWaveSpinner(
            color: Colors.grey,
            waveColor: AppColor.primaryColor,
            trackColor: AppColor.primaryColor,
          ),
        );
      } else {
        return Column(
          children: [
            // Welcome Banner Section
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: containerShadow,
                image: const DecorationImage(
                  image: AssetImage("asset/images/banner_image.png"),
                  fit: BoxFit.cover,
                  opacity: 0.15,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sliderController.fontSize.value,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  Obx(() => Text(
                        'MUF Quran',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sliderController.fontSize.value + 5,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Obx(() => Text(
                        'by Muslim Ummah Foundation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sliderController.fontSize.value - 2,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ],
              ),
            ),
            // Empty state check
            surahController.allSurahList.isEmpty
                ? Expanded(
                    child: Center(
                      child: Obx(() => Text(
                            "No Surahs found",
                            style: TextStyle(
                              fontSize: sliderController.fontSize.value,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryTextColorForTitle,
                            ),
                          )),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: surahController.allSurahList.length,
                      itemBuilder: (context, index) {
                        final surah = surahController.allSurahList[index];
                        return Bounceable(
                          onTap: () {
                            Get.to(() => SurahAyatView(
                                  surahNumber: surah.suraNumber,
                                  surahName: surah.suraName,
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColor.indexTextColor,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: listTileShadow,
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12.w),
                              leading: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FittedBox(
                                    child: Obx(() => Text(
                                          surah.suraNumber.toString(),
                                          style: TextStyle(
                                            color: AppColor.indexTextColor,
                                            fontSize: sliderController.fontSize.value - 2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              title: Obx(() => Text(
                                    surah.suraName,
                                    style: TextStyle(
                                      color: AppColor.primaryTextColorForTitle,
                                      fontWeight: FontWeight.w500,
                                      fontSize: sliderController.fontSize.value,
                                    ),
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      }
    });
  }
}
