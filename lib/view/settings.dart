import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/app_fontsize_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SliderController sliderController = Get.put(SliderController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Font Size",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
                  'Value: ${sliderController.fontSize.value.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: sliderController.fontSize.value),
                )),
            Obx(() => Slider(
                  value: sliderController.fontSize.value,
                  min: 10,
                  max: 40,
                  divisions: 30,
                  label: sliderController.fontSize.value.toStringAsFixed(1),
                  onChanged: (value) {
                    sliderController.saveFontSize(value);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
