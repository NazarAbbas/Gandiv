// class NewsList {
//   int? newsId;
//   int? locationId;
//   String? heading;
//   String? subHeading;
//   String? content;
//   String? newsImage;
//   String? createdDateTime;
//   bool? isBookmark;
//   bool? isAudioPlaying;

//   NewsList(
//       {this.newsId,
//       this.locationId,
//       this.heading,
//       this.subHeading,
//       this.content,
//       this.newsImage,
//       this.createdDateTime,
//       this.isBookmark,
//       this.isAudioPlaying});

//   NewsList.fromJson(Map<String, dynamic> json) {
//     newsId = json['newsId'];
//     locationId = json['locationId'];
//     heading = json['heading'];
//     subHeading = json['subHeading'];
//     content = json['content'];
//     newsImage = json['newsImage'];
//     createdDateTime = json['createdDateTime'];
//     isBookmark = json["is_bookmark"];
//     isAudioPlaying = json["is_audio_playing"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['newsId'] = newsId;
//     data['locationId'] = locationId;
//     data['heading'] = heading;
//     data['subHeading'] = subHeading;
//     data['content'] = content;
//     data['newsImage'] = newsImage;
//     data['createdDateTime'] = createdDateTime;
//     data['is_bookmark'] = isBookmark;
//     data['is_audio_playing'] = isAudioPlaying;
//     return data;
//   }
// }
