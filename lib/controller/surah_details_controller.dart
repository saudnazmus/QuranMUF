import 'package:get/get.dart';
import 'package:quran/model/surah_details_model.dart';
import 'package:quran/service/surah_details_service.dart';


class SurahDetailsController extends GetxController {
   String surahNumber = '';
   SurahDetailsController({required this.surahNumber});
  var surahResponse = SurahDetailsModel(
    code: 0,
    status: '',
    data: SurahData(
      number: 0,
      name: '',
      englishName: '',
      englishNameTranslation: '',
      revelationType: '',
      numberOfAyahs: 0,
      ayahs: [],
      edition: Edition(
        identifier: '',
        language: '',
        name: '',
        englishName: '',
        format: '',
        type: '',
        direction: '',
      ),
    ),
  ).obs;

  var isLoading = true.obs;

  final SurahDetailsService _surahService = SurahDetailsService();

 

  @override
  void onInit() {
    fetchSurah(surahNumber);
    super.onInit();
  }

  void fetchSurah(String surahNumber) async {
    try {
      isLoading(true);
      var result = await _surahService.fetchSurahData(surahNumber);
      if (result != null) {
        surahResponse.value = result;
      } else {
        print("Failed to fetch Surah data");
      }
    } finally {
      isLoading(false);
    }
  }
}
