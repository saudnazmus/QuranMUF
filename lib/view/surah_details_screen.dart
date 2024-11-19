import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/check_internet_connection.dart';
import 'package:quran/controller/surah_arabic_details_controller.dart';
import 'package:quran/controller/surah_details_controller.dart';

class SurahDetailsScreen extends StatelessWidget {
  String surahNumber = '';

  SurahDetailsScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final SurahDetailsController controller =
        Get.put(SurahDetailsController(surahNumber: surahNumber));
    final SurahArabicDetailsController arabicController =
        Get.put(SurahArabicDetailsController(surahNumber: surahNumber));
        final NetworkController networkController = Get.find<NetworkController>();
    return Obx(() {
      if (!networkController.isConnected.value) {
        return Scaffold(
          body: Center(child: Text('Checking connection...')),
        );
      } else {
        return Obx(
          () {
            if ((controller.isLoading.value) &&
                (arabicController.isLoading.value)) {
              return const Center(
                child: Scaffold(
                  body: Center(
                    child: SpinKitWaveSpinner(
                      color: Colors.grey,
                      waveColor: Colors.green,
                      trackColor: Colors.green,
                    ),
                  ),
                ),
              );
            } else {
              if ((arabicController
                      .surahResponse.value.data.ayahs.isNotEmpty) &&
                  (controller.surahResponse.value.data.ayahs.isNotEmpty)) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      controller.surahResponse.value.data.englishName ?? "",
                    ),
                  ),
                  body: Column(
                    children: [
                      Container(
                        // height: 100.h,
                        width: double.infinity,
                        margin: EdgeInsets.all(16.w),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: containerShadow,
                          image: const DecorationImage(
                              image:
                                  AssetImage("asset/images/banner_image.png"),
                              fit: BoxFit.cover,
                              opacity: 0.16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textDirection: arabicController
                                                .surahResponse
                                                .value
                                                .data
                                                .edition
                                                .direction ==
                                            null
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    controller.surahResponse.value.data.name
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25.sp),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              textDirection: controller.surahResponse.value.data
                                          .edition.direction ==
                                      "rtl"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              controller.surahResponse.value.data.englishName,
                              style: TextStyle(
                                // fontFamily: "SourGummy",
                                color: Colors.white,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              textDirection: controller.surahResponse.value.data
                                          .edition.direction ==
                                      "rtl"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              controller.surahResponse.value.data
                                  .englishNameTranslation,
                              style: TextStyle(
                                // fontFamily: "SourGummy",
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Text(
                              textDirection: controller.surahResponse.value.data
                                          .edition.direction ==
                                      "rtl"
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              "Total: ${controller.surahResponse.value.data.ayahs.length} Ayahs",
                              style: TextStyle(
                                // fontFamily: "SourGummy",
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.surahResponse.value.data.ayahs.isEmpty &&
                              arabicController
                                  .surahResponse.value.data.ayahs.isEmpty
                          ? const Center(
                              child: Text("No data found"),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: arabicController
                                    .surahResponse.value.data.ayahs.length,
                                itemBuilder: (context, index) {
                                  var ayah = controller
                                      .surahResponse.value.data.ayahs[index];
                                  var arabicAyah = arabicController
                                      .surahResponse.value.data.ayahs[index];
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
                                        left: 16.w,
                                        right: 16.w,
                                        bottom: 6.h,
                                        top: 6.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                  child: Text(
                                                      ayah.numberInSurah
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .indexTextColor,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                textDirection: arabicController
                                                            .surahResponse
                                                            .value
                                                            .data
                                                            .edition
                                                            .direction ==
                                                        null
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                                arabicAyah.text.toString(),
                                                style: TextStyle(
                                                    color: AppColor
                                                        .primaryTextColorForTitle,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 19.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                        verticalGap(5.h),
                                        Text(
                                          textDirection: controller
                                                      .surahResponse
                                                      .value
                                                      .data
                                                      .edition
                                                      .direction ==
                                                  "rtl"
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          ayah.text.toString(),
                                          style: TextStyle(
                                              color: AppColor
                                                  .primaryTextColorForTitle,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Scaffold(
                    body: Center(
                      child: SpinKitWaveSpinner(
                        color: Colors.grey,
                        waveColor: Colors.green,
                        trackColor: Colors.green,
                      ),
                    ),
                  ),
                );
              }
            }
          },
        );
      }
    });
  }
}
