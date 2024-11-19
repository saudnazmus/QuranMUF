import 'package:get/get.dart';
import 'package:quran/model/all_surah_list_model.dart';
import 'package:quran/service/all_surah_list_service.dart';

class AllSurahListController extends GetxController {
  RxBool isloading = false.obs;
  RxList<AllSurahListModel> allSurahList = <AllSurahListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllSurahList();
  }

  Future<void> getAllSurahList() async {
    isloading.value = true;
    final data = await AllSurahListService().getAllSurahList();
    allSurahList.value = data;
    isloading.value = false;
    print(allSurahList);
  }
}
