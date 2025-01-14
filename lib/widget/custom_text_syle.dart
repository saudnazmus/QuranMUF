import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/app_fontsize_controller.dart';

TextStyle customTextStyle() {
  final SliderController sliderController = Get.find();
  return TextStyle(fontSize: sliderController.fontSize.value);
}
