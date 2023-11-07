import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@entity
@JsonSerializable()
class NewsListDB {
  @primaryKey
  final String? id;
  final String? heading;
  final String? subHeading;
  final String? newsContent;
  final String? categoryList;
  final String? location;
  final String? language;
  final String? imageListDb;
  final String? videoListDb;
  final String? audioListDb;
  final String? publishedOn;
  final String? publishedBy;
  bool? isBookmark;
  bool? isAudioPlaying;
  final int? durationInMin;
  String? newsType;

  NewsListDB({
    required this.id,
    required this.heading,
    required this.subHeading,
    required this.newsContent,
    required this.categoryList,
    required this.location,
    required this.language,
    required this.imageListDb,
    required this.videoListDb,
    required this.audioListDb,
    required this.publishedOn,
    required this.publishedBy,
    required this.isBookmark,
    required this.isAudioPlaying,
    required this.durationInMin,
    required this.newsType,
  });

  factory NewsListDB.fromRawJson(String str) =>
      NewsListDB.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsListDB.fromJson(Map<String, dynamic> json) => NewsListDB(
        id: json["id"],
        heading: json["heading"],
        subHeading: json["subHeading"],
        newsContent: json["newsContent"],
        categoryList: json["categoryList"],
        location: json["location"],
        language: json["language"],
        imageListDb: json["imageList"],
        videoListDb: json["videoList"],
        audioListDb: json["audioList"],
        publishedOn: json["publishedOn"],
        publishedBy: json["publishedBy"],
        isBookmark: json["isBookmark"],
        isAudioPlaying: json["isAudioPlaying"],
        durationInMin: json["durationInMin"],
        newsType: json["newsType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "heading": heading,
        "subHeading": subHeading,
        "newsContent": newsContent,
        "categoryList": categoryList,
        "location": location,
        "language": language,
        "imageList": imageListDb,
        "videoList": imageListDb,
        "audioList": imageListDb,
        "publishedOn": publishedOn,
        "publishedBy": publishedBy,
        "isBookmark": isBookmark,
        "isAudioPlaying": isAudioPlaying,
        "durationInMin": durationInMin,
        "newsType": newsType,
      };
}
