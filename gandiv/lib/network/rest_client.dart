import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gandiv/models/about_us_response.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:gandiv/models/e_paper.dart';
import 'package:gandiv/models/locations_response.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/advertisement_response.dart';

part 'rest_client.g.dart';

class Apis {
  //static const String signup = '/accounts/register';
  //static const String login = '/accounts/login';
  //static const String verify = '/accounts/verify/{code}';
  // static const String forgotPassword = '/accounts/forgot-password';
  static const String aboutUs = '/Gandiv/aboutus';
  static const String ePaper = '/Gandiv/epaper';
  static const String newsList = '/news';
  static const String newsCategories = '/news/categories';
  static const String newsLocations = '/news/locations';
  static const String advertisements = '/advertisements';
  //static const String createNews = '/news/create';
  //static const String updateProfile = '/users/profile';
  //static const String getProfile = '/users/profile';
  //static const String changePassword = '/users/change-password';
}

@RestApi(baseUrl: "https://api.gandivsamachar.com/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(Apis.aboutUs)
  Future<AboutUsResponse> aboutusApi();

  @GET(Apis.ePaper)
  Future<EPaperResponse> ePaperApi();

  @GET(Apis.newsCategories)
  Future<CategoriesResponse> newsCategoryApi();

  @GET(Apis.newsLocations)
  Future<LocationsResponse> newsLocationsApi();

  @GET(Apis.advertisements)
  Future<AdvertisementResponse> advertisementsApi();

  @GET(Apis.newsList)
  Future<NewsListResponse> newsListApi(
      [@Query("CategoryId") String? categoryId,
      @Query("LocationId") String? locationId,
      @Query("LanguageId") int? laguageId,
      @Query("PageSize") int? pageSize,
      @Query("PageNumber") int? pageNumber,
      @Query("NewsTypeId") int? newsTypeId,
      @Query("SearchText") String? searchText]);
}
