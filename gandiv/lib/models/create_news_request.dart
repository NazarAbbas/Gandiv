import 'dart:convert';
import 'dart:io';

class CreateNewsRequest {
  String? heading;
  String? subHeading;
  String? newsContent;
  String? durationInMin;
  String? locationId;
  List<String>? categoryIdsList;
  String? languageId;
  String? status;
  List<File>? files;

  CreateNewsRequest({
    this.heading,
    this.subHeading,
    this.newsContent,
    this.durationInMin,
    this.locationId,
    this.categoryIdsList,
    this.languageId,
    this.status,
    this.files,
  });

  factory CreateNewsRequest.fromRawJson(String str) =>
      CreateNewsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateNewsRequest.fromJson(Map<String, dynamic> json) =>
      CreateNewsRequest(
        heading: json["heading"],
        subHeading: json["subHeading"],
        newsContent: json["newsContent"],
        durationInMin: json["durationInMin"],
        locationId: json["locationId"],
        categoryIdsList: json["categoryId"],
        languageId: json["languageId"],
        status: json["status"],
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "subHeading": subHeading,
        "newsContent": newsContent,
        "durationInMin": durationInMin,
        "locationId": locationId,
        "categoryId": categoryIdsList,
        "languageId": languageId,
        "status": status,
        "files": files,
      };
}
