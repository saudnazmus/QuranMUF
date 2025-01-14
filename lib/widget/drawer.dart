import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/view/settings.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/app_color.dart';
import '../constant/constant_design.dart';
import '../controller/app_fontsize_controller.dart'; // Import SliderController

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sliderController =
        Get.find<SliderController>(); // Get the controller

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            verticalGap(16.h),
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
                        fontSize: sliderController.fontSize.value +
                            2, // Dynamic font size
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'MUF Quran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sliderController.fontSize.value +
                          5, // Dynamic font size
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'by Muslim Ummah Foundation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sliderController.fontSize.value +
                          2, // Dynamic font size
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // verticalGap(6.h),
            const Divider(),
            verticalGap(6.h),
            // Home Option

            // Settings Option
            ListTile(
              leading:
                  Icon(Icons.settings_outlined, color: AppColor.primaryColor),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize:
                        sliderController.fontSize.value, // Dynamic font size
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Get.to(const SettingsScreen());
              },
            ),

            // Share Option
            ListTile(
              leading: Icon(Icons.share_outlined, color: AppColor.primaryColor),
              title: Text(
                "Share App",
                style: TextStyle(
                    fontSize:
                        sliderController.fontSize.value, // Dynamic font size
                    fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Share logic (e.g., using share_plus package)
                Share.share("Check out MUF Quran!");
                print("Share App clicked");
              },
            ),

            // Website Option
            ListTile(
              leading: Icon(Icons.web_outlined, color: AppColor.primaryColor),
              title: Text(
                "Visit Website",
                style: TextStyle(
                    fontSize:
                        sliderController.fontSize.value, // Dynamic font size
                    fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                if (await canLaunchUrl(
                    Uri.parse('https://www.muslimummahfoundation.org/'))) {
                  launchUrl(
                      Uri.parse('https://www.muslimummahfoundation.org/'));
                } else {
                  print('Could not launch https://muslimummahfoundation.org/');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
