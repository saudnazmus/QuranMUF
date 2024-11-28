import 'package:get/get.dart';
import 'package:quran/database/all_surah_database_helper.dart';
import 'package:quran/model/all_surah_list_model.dart';
import 'package:quran/service/all_surah_list_service.dart'; // Import the service

class AllSurahListController extends GetxController {
  var allSurahList = <AllSurahListModel>[].obs; // Observable list for storing Surah data
  var isLoading = true.obs; // Observable for tracking loading state
  var errorMessage = ''.obs; // Observable for error message if any

  // Fetch Surah data from local database or API
  Future<void> fetchSurahData() async {
    try {
      isLoading(true); // Set loading to true
      print("Fetching Surah data...");

      // Fetch local data
      List<AllSurahListModel> localData = await LocalDatabaseHelper().fetchSurahList();
      
      // If local data exists, use it; otherwise, call the API
      if (localData.isNotEmpty) {
        allSurahList.value = localData; // Use local data
        print("Successfully fetched Surah data from local database");
      } else {
        var data = await AllSurahListService().fetchSurahData(); 
        allSurahList.value = data; 
        await LocalDatabaseHelper().insertSurahList(data); 
        print("Successfully fetched Surah data from API and saved to local database");
      }
    } catch (e) {
      errorMessage.value = 'Failed to load Surah data: $e';
      print("Error: Failed to load Surah data: $e");
    } finally {
      isLoading(false); 
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSurahData(); 
  }
}
