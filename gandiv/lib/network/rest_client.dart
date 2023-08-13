import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gandiv/models/about_us_response.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:gandiv/models/e_paper.dart';
import 'package:gandiv/models/forgot_password_response.dart';
import 'package:gandiv/models/locations_response.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:gandiv/models/login_response.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:gandiv/models/profile_response.dart';
import 'package:gandiv/models/update_profile_request.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/create_news_request.dart';
import '../models/create_news_response.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import '../models/update_profile_response.dart';
import '../models/verify_response.dart';

part 'rest_client.g.dart';

class Apis {
  static const String signup = '/accounts/register';
  static const String login = '/accounts/login';
  static const String verify = '/accounts/verify/{code}';
  static const String forgotPassword = '/accounts/forgot-password';
  static const String aboutUs = '/Gandiv/aboutus';
  static const String ePaper = '/Gandiv/epaper';
  static const String newsList = '/news';

  static const String newsCategories = '/news/categories';
  static const String newsLocations = '/news/locations';
  static const String createNews = '/news/create';
  static const String updateProfile = '/users/profile';
  static const String getProfile = '/users/profile';
}

@RestApi(baseUrl: "http://devapi.gandivsamachar.com/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/users")
  Future<List<NewsList>> getUsers();

  @POST(Apis.signup)
  Future<SignupResponse> signupApi(@Body() SignupRequest signupRequest);

  @POST(Apis.login)
  Future<LoginResponse> loginApi(@Body() LoginRequest loginRequest);

  @MultiPart()
  @POST(Apis.createNews)
  Future<CreateNewsResponse> createNewsApi(
      {@required @Header('Authorization') String? token,
      @required @Part(name: 'Heading') String? heading,
      @required @Part(name: 'SubHeading') String? subHeading,
      @required @Part(name: 'NewsContent') String? newsContent,
      @required @Part(name: 'LocationId') String? locationId,
      @required @Part(name: 'Status') String? status,
      @required @Part(name: 'LanguageId') String? languageId,
      @required @Part(name: 'DurationInMin') String? durationInMin,
      @required @Part(name: 'CategoryIds') List<String>? categoryId,
      @required @Part(name: 'MediaFiles') List<File>? files});

  @MultiPart()
  @PUT(Apis.updateProfile)
  Future<UpdateProfilleResponse> updateProfileApi(
      {@required @Header('Authorization') String? token,
      @required @Part(name: 'FirstName') String? firstName,
      @required @Part(name: 'LastName') String? lastName,
      @required @Part(name: 'MobileNo') String? mobileNo,
      @required @Part(name: 'File') File? file});

  // @PUT(Apis.updateProfile)
  // Future<UpdateProfilleResponse> updateProfileApi(
  //     @Header('Authorization') String? token,
  //     @Body() UpdateProfileRequest updateProfileRequest);

  // @MultiPart()
  // @POST(Apis.createNews)
  // Future<CreateNewsResponse> createNewsApi(
  //     {@required @Header('Authorization') String? token,
  //     @required @Part(name: 'Heading') String? heading,
  //     @required @Part(name: 'SubHeading') String? subHeading,
  //     @required @Part(name: 'newsContent') String? newsContent,
  //     @required @Part(name: 'LocationId') String? locationId,
  //     @required @Part(name: 'Status') String? status,
  //     @required @Part(name: 'LanguageId') String? languageId,
  //     @required @Part(name: 'DurationInMin') String? durationInMin,
  //     @required @Part(name: 'CategoryId') String? categoryId,
  //     @required @Part(name: 'MediaFiles') List<http.MultipartFile>? mediaFiles});

  @PUT(Apis.verify)
  Future<VerifyResponse> verifyApi(@Path("code") String code);

  @GET(Apis.getProfile)
  Future<ProfileResponse> profileApi(@Header('Authorization') String? token);

  @PUT(Apis.forgotPassword)
  Future<VerifyResponse> forgotPasswordApi(
      @Query("username") String userName, @Query("password") String password);

  @GET(Apis.aboutUs)
  Future<AboutUsResponse> aboutusApi();

  @GET(Apis.ePaper)
  Future<EPaperResponse> ePaperApi();

  @GET(Apis.newsCategories)
  Future<CategoriesResponse> newsCategoryApi();

  @GET(Apis.newsLocations)
  Future<LocationsResponse> newsLocationsApi();

  @GET(Apis.newsList)
  Future<NewsListResponse> newsListApi(
      [@Query("CategoryId") String? categoryId,
      @Query("LocationId") String? locationId,
      @Query("LanguageId") int? laguageId,
      @Query("PageSize") int? pageSize,
      @Query("PageNumber") int? pageNumber,
      @Query("SearchText") String? searchText]);

  @PUT(Apis.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword([
    @Query("username") String? username,
  ]);
}
