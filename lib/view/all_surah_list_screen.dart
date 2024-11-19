import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/all_surah_list_controller.dart';
import 'package:quran/controller/check_internet_connection.dart';
import 'package:quran/view/surah_details_screen.dart';
import 'package:quran/widget/numbet_background.dart';

class AllSurahListScreen extends StatelessWidget {
  const AllSurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AllSurahListController controller = Get.put(AllSurahListController());
            final NetworkController networkController = Get.find<NetworkController>();
    return Obx(() {
      if (!networkController.isConnected.value) {
        return Scaffold(
          body: Center(child: Text('Checking connection...')),
        );
      } else {
        return Obx(() {
          if (controller.isloading.value) {
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
                        image: AssetImage("asset/images/banner_image.png"),
                        fit: BoxFit.cover,
                        opacity: 0.153),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            // fontFamily: "SourGummy",
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Al-Quran',
                        style: TextStyle(
                          // fontFamily: "SourGummy",
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'by Muslim Ummah Foundation',
                        style: TextStyle(
                          // fontFamily: "SourGummy",
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                controller.allSurahList.isEmpty
                    ? const Center(
                        child: Text("No data found"),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.allSurahList.length,
                          itemBuilder: (context, index) {
                            return Bounceable(
                              onTap: () {
                                Get.to(() => SurahDetailsScreen(
                                      surahNumber: controller
                                          .allSurahList[index].number
                                          .toString(),
                                    ));
                              },
                              child: Container(
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
                                child: ListTile(
                                  leading: Container(
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      // borderRadius: BorderRadius.circular(10.r),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                            controller
                                                .allSurahList[index].number
                                                .toString(),
                                            style: TextStyle(
                                                color: AppColor.indexTextColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    controller.allSurahList[index].englishName
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                            AppColor.primaryTextColorForTitle,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    controller.allSurahList[index]
                                        .englishNameTranslation
                                        .toString(),
                                    style: TextStyle(
                                        color: AppColor.primarySbuTitleColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  trailing: Text(
                                    controller
                                        .allSurahList[index].revelationType
                                        .toString(),
                                    style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp),
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
    });
  }
}
