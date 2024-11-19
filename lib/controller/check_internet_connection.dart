// network_controller.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:quran/view/error_page.dart';
import 'package:quran/view/home_screen.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs; // Observable boolean for network status
  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen((event) {});
  }

  updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      isConnected.value = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
    } 
     else if (connectivityResult.contains(ConnectivityResult.none)) {
      isConnected.value = false;
    }
  }
}
