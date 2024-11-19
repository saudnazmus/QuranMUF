import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quran/constant/api_endpoint.dart';
import 'package:quran/model/all_surah_list_model.dart';

class AllSurahListService {
  final String apiUrl = all_surah_list_url;

  Future<List<AllSurahListModel>> getAllSurahList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Extract the list if it is wrapped in a map
        if (data.containsKey('data') && data['data'] is List) {
          List<dynamic> surahList = data['data'];
          return surahList
              .map((json) => AllSurahListModel.fromJson(json))
              .toList();
        } else {
          print('Error: Unexpected response structure.');
          return [];
        }
      } else {
        print('Error: Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
