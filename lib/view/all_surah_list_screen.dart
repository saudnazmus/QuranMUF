import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/all_surah_list_controller.dart';
import 'package:quran/view/ayah_of_surah_screen.dart';

class AllSurahListScreen extends StatelessWidget {
  const AllSurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AllSurahListController controller = Get.put(AllSurahListController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: SpinKitWaveSpinner(
            color: Colors.grey,
            waveColor: Colors.green,
            trackColor: Colors.green,
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
                    opacity: 0.153),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'MUF Quran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'by Muslim Ummah Foundation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Empty state check
            controller.allSurahList.isEmpty
                ? const Center(
                    child: Text(
                      "No Surahs found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: controller.allSurahList.length,
                      itemBuilder: (context, index) {
                        return Bounceable(
                          onTap: () {
                            // Handle tap if needed
                            Get.to(() => SurahAyatView(
                                  surahNumber:
                                      controller.allSurahList[index].suraNumber,
                                  surahName:
                                      controller.allSurahList[index].suraName,
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
                                    child: Text(
                                      controller.allSurahList[index].suraNumber
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColor.indexTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                controller.allSurahList[index].suraName
                                    .toString(),
                                style: TextStyle(
                                  color: AppColor.primaryTextColorForTitle,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
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
