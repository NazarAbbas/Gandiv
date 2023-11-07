import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class AdvertisementResponse {
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final AdvertisementData advertisementData;

  AdvertisementResponse({
    required this.status,
    required this.message,
    required this.advertisementData,
  });

  factory AdvertisementResponse.fromRawJson(String str) =>
      AdvertisementResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertisementResponse.fromJson(Map<String, dynamic> json) =>
      AdvertisementResponse(
        status: json["status"],
        message: json["message"],
        advertisementData: AdvertisementData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": advertisementData.toJson(),
      };
}

class AdvertisementData {
  final String splashUrl;
  final List<Advertisement> advertisements;

  AdvertisementData({
    required this.splashUrl,
    required this.advertisements,
  });

  factory AdvertisementData.fromRawJson(String str) =>
      AdvertisementData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdvertisementData.fromJson(Map<String, dynamic> json) =>
      AdvertisementData(
        splashUrl: json["splashUrl"],
        advertisements: List<Advertisement>.from(
            json["advertisements"].map((x) => Advertisement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "splashUrl": splashUrl,
        "advertisements":
            List<dynamic>.from(advertisements.map((x) => x.toJson())),
      };
}

class Advertisement {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'url')
  final String? url;
  @JsonKey(name: 'placeHolder')
  final String? placeHolder;
  @JsonKey(name: 'mediaUrl')
  final String? mediaUrl;

  Advertisement({
    required this.id,
    required this.url,
    required this.placeHolder,
    required this.mediaUrl,
  });

  factory Advertisement.fromRawJson(String str) =>
      Advertisement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        id: json["id"],
        url: json["url"],
        placeHolder: json["placeHolder"],
        mediaUrl: json["mediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "placeHolder": placeHolder,
        "mediaUrl": mediaUrl,
      };
}
