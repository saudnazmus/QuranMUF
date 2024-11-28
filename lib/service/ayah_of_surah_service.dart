import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/constant/api_endpoint.dart';
import 'package:quran/model/ayah_of_surah_model.dart';

class SurahAyatService {
  // Fetch Surah data from an API by Surah ID
  Future<List<SurahAyatModel>> fetchSurahDataFromApi(int surahId) async {
    try {
      final response = await http.get(Uri.parse(
          '$surah_detail_url$surahId')); // Replace with your API URL that accepts Surah ID

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => SurahAyatModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Surah data from API');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Fetch Surah data from local database (if needed)
 
}
