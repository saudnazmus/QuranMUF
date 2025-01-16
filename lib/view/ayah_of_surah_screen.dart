import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran/constant/app_color.dart';
import 'package:quran/constant/constant_design.dart';
import 'package:quran/controller/ayah_of_surah_controller.dart';
import 'package:quran/view/home_screen.dart';
import 'package:quran/widget/text.dart';
import '../controller/app_fontsize_controller.dart';

class SurahAyatView extends StatelessWidget {
  const SurahAyatView({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  final int surahNumber;
  final String surahName;

  @override
  Widget build(BuildContext context) {
    final SurahAyatController controller =
        Get.put(SurahAyatController(surahId: surahNumber));
    final SliderController sliderController = Get.find<SliderController>();
    final ScrollController scrollController = ScrollController();
    final RxBool isFabVisible = true.obs;

    // Monitor scroll events to hide/show the FAB
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isFabVisible.value = false;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        isFabVisible.value = true;
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: SpinKitWaveSpinner(
                color: Colors.grey,
                waveColor: Color.fromARGB(255, 76, 94, 175),
                trackColor: Color.fromARGB(255, 76, 94, 175),
              ),
            );
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(
                  fontSize: sliderController.fontSize.value,
                  color: Colors.redAccent,
                ),
              ),
            );
          } else {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  expandedHeight: (sliderController.fontSize.value * 7) +
                      kToolbarHeight, // Adjust height dynamically
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double collapsePercent =
                          (constraints.maxHeight - kToolbarHeight) /
                              ((sliderController.fontSize.value * 7) -
                                  kToolbarHeight);

                      return FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, // Keep it relative to design
                          vertical: 12.0,
                        ),
                        title: collapsePercent < 0.5
                            ? Text(
                                surahName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: sliderController.fontSize.value + 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                        background: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(16.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: containerShadow,
                            image: const DecorationImage(
                              image:
                                  AssetImage("asset/images/banner_image.png"),
                              fit: BoxFit.cover,
                              opacity: 0.15,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => Text(
                                    'MUF Quran',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          sliderController.fontSize.value + 5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              Obx(() => Text(
                                    'by Muslim Ummah Foundation',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize:
                                          sliderController.fontSize.value - 2,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                              SizedBox(
                                  height: sliderController.fontSize.value *
                                      0.5), // Responsive spacing
                              Obx(() => Text(
                                    'Surah: $surahName',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          sliderController.fontSize.value + 5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ayat = controller.allSurahList[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.indexTextColor,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: listTileShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 35.w,
                                  height: 35.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      ayat.ayetNumber.toString(),
                                      style: TextStyle(
                                        color: AppColor.indexTextColor,
                                        fontSize:
                                            sliderController.fontSize.value,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: GlobalText(
                                    text: ayat.ayatArabic,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      color: AppColor.primaryTextColorForTitle,
                                      fontSize: sliderController.fontSize.value,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            verticalGap(10.h),
                            GlobalText(
                              text: ayat.ayatBangla,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColor.primaryTextColorForTitle,
                                fontSize: sliderController.fontSize.value,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: controller.allSurahList.length,
                  ),
                ),
              ],
            );
          }
        }),
      ),
      floatingActionButton: Obx(() {
        return isFabVisible.value
            ? FloatingActionButton(
                backgroundColor: AppColor.primaryColor,
                onPressed: () {
                  Get.offAll(const HomeScreen());
                },
                child: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
