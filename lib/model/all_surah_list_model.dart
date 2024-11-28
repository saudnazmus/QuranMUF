class AllSurahListModel {
  final int id;
  final String suraName;
  final int suraNumber;

  AllSurahListModel({
    required this.id,
    required this.suraName,
    required this.suraNumber,
  });

  // Factory constructor to create an AllSurahListModel from JSON data
  factory AllSurahListModel.fromJson(Map<String, dynamic> json) {
    return AllSurahListModel(
      id: json['id'],
      suraName: json['sura_name'],
      suraNumber: json['sura_number'],
    );
  }

  // Convert model to map for inserting into the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sura_name': suraName,
      'sura_number': suraNumber,
    };
  }

  // Convert map to model when reading from the database
  factory AllSurahListModel.fromMap(Map<String, dynamic> map) {
    return AllSurahListModel(
      id: map['id'],
      suraName: map['sura_name'],
      suraNumber: map['sura_number'],
    );
  }
}
