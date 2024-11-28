import 'package:get/get.dart';
import 'package:quran/database/all_surah_database_helper.dart';
import 'package:quran/model/ayah_of_surah_model.dart';
import 'package:quran/service/ayah_of_surah_service.dart';


class SurahAyatController extends GetxController {
  var allSurahList = <SurahAyatModel>[].obs; // Observable list for storing Surah data
  var isLoading = true.obs; // Observable for tracking loading state
  var errorMessage = ''.obs; // Observable for error message if any
  int surahId;
  
  final SurahAyatService surahAyatService = SurahAyatService();

  SurahAyatController({required this.surahId});

  // Fetch Surah data from local database or API using Surah ID
  Future<void> fetchSurahData(int surahId, {bool forceUpdate = false}) async {
    try {
      isLoading(true); // Set loading to true
      print("Fetching Surah data...");

      if (forceUpdate) {
        // Fetch data from API and update local database
        List<SurahAyatModel> data = await surahAyatService.fetchSurahDataFromApi(surahId);
        allSurahList.value = data; // Update the observable list with fetched data
        await saveSurahDataToLocal(data); // Save to local database
        print("Successfully fetched Surah data from API");
      } else {
        // Fetch data from local database
        List<SurahAyatModel> localData = await fetchSurahDataFromLocal();
        if (localData.isNotEmpty) {
          allSurahList.value = localData; // Use local data if available
          print("Successfully fetched Surah data from local database");
        } else {
          // If no local data, fetch from API
          List<SurahAyatModel> data = await surahAyatService.fetchSurahDataFromApi(surahId);
          allSurahList.value = data;
          await saveSurahDataToLocal(data); // Save to local database
          print("Successfully fetched Surah data from API");
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to load Surah data: $e'; // Update error message
      print("Error: Failed to load Surah data: $e");
    } finally {
      isLoading(false); // Set loading to false after the operation completes
    }
  }

  // Fetch Surah data from local database
  Future<List<SurahAyatModel>> fetchSurahDataFromLocal() async {
    return await LocalDatabaseHelper().fetchAyahListBySurah(surahId);
  }

  // Save Surah data to local database
  Future<void> saveSurahDataToLocal(List<SurahAyatModel> ayahList) async {
    await LocalDatabaseHelper().insertAyahList(ayahList);
  }

  // Insert a single SurahAyatModel into the local database
  Future<void> insertSurahAyat(SurahAyatModel ayah) async {
    await LocalDatabaseHelper().insertAyahList([ayah]);
  }

  // Delete a SurahAyatModel by its ID from the local database


  // Delete all SurahAyatModels from the local database for this Surah


  @override
  void onInit() {
    super.onInit();
    fetchSurahData(surahId); // Fetch data for the given Surah ID
  }
}
