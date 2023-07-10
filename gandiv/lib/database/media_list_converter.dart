import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:gandiv/models/news_list_response.dart';

class MediaListConverter extends TypeConverter<List<MediaList>, String> {
  @override
  List<MediaList> decode(String databaseValue) {
    final jsonFile = json.decode(databaseValue);
    List<MediaList> finances = [];
    finances = List.from(jsonFile['mediaList'])
        .map((e) => MediaList.fromJson(jsonDecode(e)))
        .toList();

    return finances;
  }

  @override
  String encode(List<MediaList> value) {
    final data = <String, dynamic>{};
    data.addAll({'mediaList': value});
    return json.encode(data);
  }
}
