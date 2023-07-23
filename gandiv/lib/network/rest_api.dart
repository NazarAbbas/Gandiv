// ignore: file_names
import 'package:dio/dio.dart';
import 'package:gandiv/models/about_us_response.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:gandiv/models/e_paper.dart';
import 'package:gandiv/models/locations_response.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:gandiv/models/login_response.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:gandiv/models/verify_response.dart';
import 'package:gandiv/network/rest_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constant.dart';

import '../models/create_news_request.dart';
import '../models/create_news_response.dart';
import '../models/dashboard_screen_model.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';
import 'package:http/http.dart' as http;

class RestAPI {
  Dio dio = Get.find<Dio>();
  init() {
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        error: true));
    dio.options.connectTimeout = const Duration(
        days: 0,
        hours: 0,
        minutes: 1,
        seconds: 0,
        microseconds: 0,
        milliseconds: 0);
    dio.options.receiveTimeout = const Duration(
        days: 0,
        hours: 0,
        minutes: 1,
        seconds: 0,
        microseconds: 0,
        milliseconds: 0);
    dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
  }

  //GET request example
  Future<List<NewsList>> getDataMethod() async {
    final client = RestClient(dio);
    final response = await client.getUsers();
    return response;
  }

  //POST signup request
  Future<SignupResponse> calllSignupApi(SignupRequest signupRequest) async {
    final client = RestClient(dio);
    final response = await client.signupApi(signupRequest);
    return response;
  }

  //POST login request
  Future<LoginResponse> calllLoginApi(LoginRequest loginRequest) async {
    final client = RestClient(dio);
    final response = await client.loginApi(loginRequest);
    return response;
  }

  //POST create news request
  Future<CreateNewsResponse> callCreateNewsApi(
      CreateNewsRequest createNewsRequest) async {
    final client = RestClient(dio);
    final token =
        "Bearer ${GetStorage().read(Constant.token) ?? "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3ODExYjg2Ny0zYzQ4LTRkZjYtMzY3My0wOGRiNzE3OWU0YzIiLCJlbWFpbCI6ImFkbWluQGdhbmRpdi5jb20iLCJhdWQiOlsiU3VwZXJBZG1pbiIsIkF1ZGllbmNlIl0sInJvbGUiOiJTdXBlckFkbWluIiwibmJmIjoxNjkwMTEyMjE5LCJleHAiOjE2OTAxMTU4MTksImlhdCI6MTY5MDExMjIxOSwiaXNzIjoiSXNzdWVyIn0.CFvO1iI-kyhRx3ptCc61tMG50lG8EN34PHmSlSCSXbUqhQPkSpZpx117Ny867PF_1AWd5ie8PwxjwS0_H4Sv0g"}";
    final response = await client.createNewsApi(
        token: token,
        heading: createNewsRequest.heading,
        subHeading: createNewsRequest.subHeading,
        newsContent: createNewsRequest.newsContent,
        locationId: createNewsRequest.locationId,
        languageId: createNewsRequest.languageId,
        status: createNewsRequest.status,
        durationInMin: createNewsRequest.durationInMin,
        categoryId: createNewsRequest.categoryId);
    return response;
  }

  //PUT login request
  Future<VerifyResponse> calllVerifyApi(String code) async {
    final client = RestClient(dio);
    final response = await client.verifyApi(code);
    return response;
  }

  //Get AboutUs request
  Future<AboutUsResponse> calllAboutUsApi() async {
    final client = RestClient(dio);
    final response = await client.aboutusApi();
    return response;
  }

  //Get EPaper request
  Future<EPaperResponse> calllEPaperApi() async {
    final client = RestClient(dio);
    final response = await client.ePaperApi();
    return response;
  }

  // //Get News request
  // Future<NewsListResponse> callNewsListApi(
  //     [String categoryId = '',
  //     String locationId = '',
  //     int pageSize = 10,
  //     int pageNumber = 1]) async {
  //   final client = RestClient(dio);
  //   final response = await client.newsListApi();
  //   return response;
  // }

  //Get News request
  Future<NewsListResponse> callNewsListApi(
      {required String categoryId,
      required String locationId,
      required int pageSize,
      required int pageNumber}) async {
    final languageId = GetStorage().read(Constant.selectedLanguage);
    final client = RestClient(dio);
    final response = await client.newsListApi(
        categoryId, locationId, languageId, pageSize, pageNumber);
    return response;
  }

  // News Locations request
  Future<LocationsResponse> calllNewsLocations() async {
    final client = RestClient(dio);
    final response = await client.newsLocationsApi();
    return response;
  }

  // News Categories request
  Future<CategoriesResponse> calllNewsCategories() async {
    final client = RestClient(dio);
    final response = await client.newsCategoryApi();
    return response;
  }
}
