class SurahAyatModel {
  final int id;
  final String ayatArabic;
  final String ayatBangla;
  final int suraName;
  final int suraNumber;
  final int ayetNumber;

  SurahAyatModel({
    required this.id,
    required this.ayatArabic,
    required this.ayatBangla,
    required this.suraName,
    required this.suraNumber,
    required this.ayetNumber,
  });

  // Convert JSON to SurahAyatModel
  factory SurahAyatModel.fromJson(Map<String, dynamic> json) {
    return SurahAyatModel(
      id: json['id'],
      ayatArabic: json['ayat_arabic'],
      ayatBangla: json['ayat_bangla'],
      suraName: json['sura_name'],
      suraNumber: json['sura_number'],
      ayetNumber: json['ayet_number'],
    );
  }

  // Convert SurahAyatModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ayat_arabic': ayatArabic,
      'ayat_bangla': ayatBangla,
      'sura_name': suraName,
      'sura_number': suraNumber,
      'ayet_number': ayetNumber,
    };
  }
}
