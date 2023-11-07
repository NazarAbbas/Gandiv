import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gandiv/database/media_list_converter.dart';

@JsonSerializable()
class NewsListResponse {
  @JsonKey(name: 'status')
  final int status;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'data')
  final NewsListData newsListData;

  NewsListResponse({
    required this.status,
    required this.message,
    required this.newsListData,
  });

  factory NewsListResponse.fromRawJson(String str) =>
      NewsListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsListResponse.fromJson(Map<String, dynamic> json) =>
      NewsListResponse(
        status: json["status"],
        message: json["message"],
        newsListData: NewsListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": newsListData.toJson(),
      };
}

@JsonSerializable()
class NewsListData {
  @JsonKey(name: 'newsList')
  final List<NewsList> newsList;
  @JsonKey(name: 'pageNumber')
  final int? pageNumber;
  @JsonKey(name: 'pageSize')
  final int? pageSize;
  @JsonKey(name: 'totalCount')
  final int? totalCount;

  NewsListData({
    required this.newsList,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
  });

  factory NewsListData.fromRawJson(String str) =>
      NewsListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsListData.fromJson(Map<String, dynamic> json) => NewsListData(
        newsList: List<NewsList>.from(
            json["newsList"].map((x) => NewsList.fromJson(x))),
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "newsList": List<NewsList>.from(newsList.map((x) => x.toJson())),
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalCount": totalCount,
      };
}

@JsonSerializable(nullable: true)
class NewsList {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'heading')
  late final String? heading;
  @JsonKey(name: 'subHeading')
  late final String? subHeading;
  @JsonKey(name: 'newsContent')
  late String? newsContent;
  @JsonKey(name: 'categories')
  List<Category>? categories;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'language')
  final String? language;
  // @TypeConverters([MediaListConverter])
  @JsonKey(name: 'mediaList')
  late MediaList? mediaList;
  @JsonKey(name: 'publishedOn')
  final String? publishedOn;
  @JsonKey(name: 'publishedBy')
  final String? publishedBy;
  @JsonKey(name: 'isBookmark')
  bool? isBookmark;
  @JsonKey(name: 'isAudioPlaying')
  bool? isAudioPlaying;
  @JsonKey(name: 'durationInMin')
  final int? durationInMin;
  @JsonKey(name: 'newsType')
  String? newsType;
  @JsonKey(name: 'newsTypeId')
  int? newsTypeId;

  @JsonKey(name: 'shortUrl')
  String? shortUrl;

  NewsList({
    this.id,
    this.heading,
    this.subHeading,
    this.newsContent,
    this.categories,
    this.location,
    this.language,
    this.mediaList,
    this.publishedOn,
    this.publishedBy,
    this.isBookmark,
    this.isAudioPlaying,
    this.durationInMin,
    this.newsType,
    this.newsTypeId,
    this.shortUrl,
  });

  factory NewsList.fromRawJson(String str) =>
      NewsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
      id: json["id"],
      heading: json["heading"],
      subHeading: json["subHeading"],
      newsContent: json["newsContent"],
      categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x))),
      location: json["location"],
      language: json["language"],
      mediaList: json["mediaList"] != null
          ? MediaList.fromJson(json["mediaList"])
          : null,
      publishedOn: json["publishedOn"],
      publishedBy: json["publishedBy"],
      isBookmark: json["isBookmark"],
      isAudioPlaying: json["isAudioPlaying"],
      durationInMin: json["durationInMin"],
      newsType: json["newsType"],
      newsTypeId: json["newsTypeId"],
      shortUrl: json["shortUrl"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "heading": heading,
        "subHeading": subHeading,
        "newsContent": newsContent,
        "categories": categories,
        "location": location,
        "language": language,
        "mediaList": mediaList,
        "publishedOn": publishedOn,
        "publishedBy": publishedBy,
        "isBookmark": isBookmark,
        "isAudioPlaying": isAudioPlaying,
        "durationInMin": durationInMin,
        "newsType": newsType,
        "newsTypeId": newsTypeId,
        "shortUrl": shortUrl
      };
}

class MediaList {
  List<ImageList>? imageList;
  List<VideoList>? videoList;
  List<AudioList>? audioList;

  MediaList({
    this.imageList,
    this.videoList,
    this.audioList,
  });

  factory MediaList.fromJson(Map<String, dynamic> json) => MediaList(
        imageList: List<ImageList>.from(
            json["imageList"].map((x) => ImageList.fromJson(x))),
        videoList: List<VideoList>.from(
            json["videoList"].map((x) => VideoList.fromJson(x))),
        audioList: List<AudioList>.from(
            json["audioList"].map((x) => AudioList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "imageList": List<dynamic>.from(imageList!.map((x) => x.toJson())),
        "videoList": List<dynamic>.from(videoList!.map((x) => x.toJson())),
        "audioList": List<dynamic>.from(audioList!.map((x) => x.toJson())),
      };
}

class ImageList {
  String? url;
  String? type;
  String? placeholder;

  ImageList({
    this.url,
    this.type,
    this.placeholder,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
        url: json["url"],
        type: json["type"],
        placeholder: json["placeholder"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "placeholder": placeholder,
      };
}

class VideoList {
  String? url;
  String? type;
  String? placeholder;

  VideoList({
    this.url,
    this.type,
    this.placeholder,
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        url: json["url"],
        type: json["type"],
        placeholder: json["placeholder"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "placeholder": placeholder,
      };
}

class AudioList {
  String? url;
  String? type;
  String? placeholder;

  AudioList({
    this.url,
    this.type,
    this.placeholder,
  });

  factory AudioList.fromJson(Map<String, dynamic> json) => AudioList(
        url: json["url"],
        type: json["type"],
        placeholder: json["placeholder"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "placeholder": placeholder,
      };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

// @JsonSerializable()
// class MediaList {
//   @JsonKey(name: 'url')
//   final String url;
//   @JsonKey(name: 'type')
//   final String type;
//   @JsonKey(name: 'placeholder')
//   final String placeholder;

//   MediaList({
//     required this.url,
//     required this.type,
//     required this.placeholder,
//   });

//   factory MediaList.fromRawJson(String str) =>
//       MediaList.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory MediaList.fromJson(Map<String, dynamic> json) => MediaList(
//         url: json["url"],
//         type: json["type"],
//         placeholder: json["placeholder"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "type": type,
//         "placeholder": placeholder,
//       };
// }
