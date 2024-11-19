import 'package:flutter/material.dart';
import 'package:quran/constant/app_color.dart';

var containerShadow = [
  BoxShadow(
    color: AppColor.boxShadowColor,
    spreadRadius: 1.3,
    blurRadius: 20,
    offset: const Offset(0, 0),
  ),
];
var listTileShadow = [
  BoxShadow(
    color: AppColor.listTileShadowColor,
    blurStyle: BlurStyle.outer,
    spreadRadius: 0.0,
    blurRadius: 15,
    offset: const Offset(0, 0),
  ),
];

verticalGap(height) {
  return SizedBox(height: height);
}

horizontalGap(width) {
  return SizedBox(width: width);
}
