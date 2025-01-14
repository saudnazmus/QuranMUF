import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderController extends GetxController {
  var fontSize = 16.0.obs; // Default font size

  // Save the font size locally
  void saveFontSize(double value) async {
    fontSize.value = value;

    // Save to local storage (optional)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', value);
  }

  // Load the saved font size
  void loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedFontSize = prefs.getDouble('fontSize');
    if (savedFontSize != null) {
      fontSize.value = savedFontSize;
    }
  }
}
