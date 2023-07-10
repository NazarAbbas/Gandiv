// ignore: file_names
import 'package:dio/dio.dart';
import 'package:gandiv/models/about_us_response.dart';
import 'package:gandiv/models/e_paper.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:gandiv/models/login_response.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:gandiv/models/verify_response.dart';
import 'package:gandiv/network/rest_client.dart';
import 'package:get/get.dart';
import '../models/dashboard_screen_model.dart';
import '../models/signup_request.dart';
import '../models/signup_response.dart';

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
    final client = RestClient(dio);
    final response = await client.newsListApi();
    return response;
  }
}
