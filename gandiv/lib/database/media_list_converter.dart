import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:gandiv/models/news_list_response.dart';

class MediaListConverter extends TypeConverter<List<MediaList>, String> {
  @override
  List<MediaList> decode(String databaseValue) {
    final jsonFile = json.decode(databaseValue);
    List<MediaList> mediaList = [];
    mediaList = List.from(jsonFile['mediaList'])
        .map((e) => MediaList.fromJson(jsonDecode(e)))
        .toList();

    return mediaList;
  }

  @override
  String encode(List<MediaList> value) {
    final data = <String, dynamic>{};
    data.addAll({'mediaList': value});
    return json.encode(data);
  }
}

// class  MediaListConverter extends TypeConverter<List<MediaList>, String>
//     with ListConverter<MediaList> {
//   @override
//   int fromDB(String databaseValue) {
//     return int.parse(databaseValue);
//   }

//   @override
//   String toDB(int value) {
//     return value.toString();
//   }
// }
