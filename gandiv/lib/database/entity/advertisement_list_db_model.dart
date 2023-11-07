import 'package:floor/floor.dart';

@entity
class AdvertisementDb {
  @primaryKey
  final String id;
  final String url;
  final String placeHolder;
  final String mediaList;

  AdvertisementDb({
    required this.id,
    required this.url,
    required this.placeHolder,
    required this.mediaList,
  });

  factory AdvertisementDb.fromJson(Map<String, dynamic> json) =>
      AdvertisementDb(
        id: json["id"],
        url: json["url"],
        placeHolder: json["placeHolder"],
        mediaList: json["mediaList"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "placeHolder": placeHolder,
        "mediaList": mediaList,
      };
}
