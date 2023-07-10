// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsListResponse _$NewsListResponseFromJson(Map<String, dynamic> json) =>
    NewsListResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      newsListData: NewsListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsListResponseToJson(NewsListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.newsListData,
    };

NewsListData _$NewsListDataFromJson(Map<String, dynamic> json) => NewsListData(
      newsList: (json['newsList'] as List<dynamic>)
          .map((e) => NewsList.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
    );

Map<String, dynamic> _$NewsListDataToJson(NewsListData instance) =>
    <String, dynamic>{
      'newsList': instance.newsList,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
    };

NewsList _$NewsListFromJson(Map<String, dynamic> json) => NewsList(
      id: json['id'] as String?,
      heading: json['heading'] as String?,
      subHeading: json['subHeading'] as String?,
      newsContent: json['newsContent'] as String?,
      category: json['category'] as String?,
      location: json['location'] as String?,
      language: json['language'] as String?,
      publishedOn: json['publishedOn'] as String?,
      publishedBy: json['publishedBy'] as String?,
      isBookmark: json['isBookmark'] as bool?,
      isAudioPlaying: json['isAudioPlaying'] as bool?,
    );

Map<String, dynamic> _$NewsListToJson(NewsList instance) => <String, dynamic>{
      'id': instance.id,
      'heading': instance.heading,
      'subHeading': instance.subHeading,
      'newsContent': instance.newsContent,
      'category': instance.category,
      'location': instance.location,
      'language': instance.language,
      'publishedOn': instance.publishedOn,
      'publishedBy': instance.publishedBy,
      'isBookmark': instance.isBookmark,
      'isAudioPlaying': instance.isAudioPlaying,
    };

MediaList _$MediaListFromJson(Map<String, dynamic> json) => MediaList(
      url: json['url'] as String,
      type: json['type'] as String,
      placeholder: json['placeholder'] as String,
    );

Map<String, dynamic> _$MediaListToJson(MediaList instance) => <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
      'placeholder': instance.placeholder,
    };
