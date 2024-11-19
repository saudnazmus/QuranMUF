import 'package:get/get.dart';
import 'package:quran/model/surah_arabic_details_model.dart';
import 'package:quran/service/surah_details_service.dart';


class SurahArabicDetailsController extends GetxController {
  String surahNumber = "";
  SurahArabicDetailsController({required this.surahNumber});
 var surahResponse = SurahArabicDetailsModel(
  code: 0,
  status: '',
  data: SurahData(
    number: 0,
    name: '',
    englishName: '',
    englishNameTranslation: '',
    revelationType: '',
    numberOfAyahs: 0,
    ayahs: [], // Empty list
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

  final SurahArabicDetailsService surahService = SurahArabicDetailsService();

  @override
  void onInit() {
    fetchSurahData(surahNumber);
    super.onInit();
  }

  void fetchSurahData(String surahNumber) async {
    try {
      isLoading(true);
      var data = await surahService.fetchSurahData(surahNumber);
      if (data != null) {
        surahResponse.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
