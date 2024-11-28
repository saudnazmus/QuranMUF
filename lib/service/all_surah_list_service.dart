import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quran/constant/api_endpoint.dart';
import 'package:quran/model/all_surah_list_model.dart';



class AllSurahListService {
  final String apiUrl = all_surah_list_url; // API URL for fetching Suras

  // Fetch Surah data from API
  Future<List<AllSurahListModel>> fetchSurahData() async {
    final response = await http.get(Uri.parse(apiUrl));

   if (response.statusCode == 200) {
  List jsonData = json.decode(response.body);
  return jsonData.map((surah) => AllSurahListModel.fromJson(surah)).toList();
} else {
  print('Error: ${response.statusCode}, ${response.body}');
  throw Exception('Failed to load Surah data');
}
  }
}
