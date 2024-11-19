import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/constant/api_endpoint.dart';
import 'package:quran/model/surah_arabic_details_model.dart';
import 'package:quran/model/surah_details_model.dart'; // Import your API endpoint file

class SurahDetailsService {
  final String apiUrl = surah_detail_url; // Replace with your actual API URL

  Future<SurahDetailsModel?> fetchSurahData(String surahNumber) async {
    try {
      final response = await http.get(Uri.parse("$apiUrl$surahNumber/bn.bengali"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return SurahDetailsModel.fromJson(jsonData);
      } else {
        print("Failed to fetch data. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while fetching data: $e");
      return null;
    }
  }
}

class SurahArabicDetailsService {
  final String apiUrl = surah_detail_url; // Replace with your actual API URL

  Future<SurahArabicDetailsModel?> fetchSurahData(String surahNumber) async {
    try {
      final response = await http.get(Uri.parse("$apiUrl$surahNumber/ar.abdulbasitmurattal"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return SurahArabicDetailsModel.fromJson(jsonData);
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }
}
