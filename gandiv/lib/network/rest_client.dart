import 'dart:ffi';

import 'package:gandiv/models/about_us_response.dart';
import 'package:gandiv/models/dashboard_screen_model.dart';
import 'package:gandiv/models/e_paper.dart';
import 'package:gandiv/models/login_request.dart';
import 'package:gandiv/models/login_response.dart';
import 'package:gandiv/models/news_list_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/signup_request.dart';
import '../models/signup_response.dart';
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
}

@RestApi(baseUrl: "http://devapi.gandivsamachar.com/api")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/users")
  Future<List<NewsList>> getUsers();

  @POST(Apis.signup)
  Future<SignupResponse> signupApi(@Body() SignupRequest signupRequest);

  @POST(Apis.signup)
  Future<LoginResponse> loginApi(@Body() LoginRequest loginRequest);

  @PUT(Apis.verify)
  Future<VerifyResponse> verifyApi(@Path("code") String code);

  @PUT(Apis.forgotPassword)
  Future<VerifyResponse> forgotPasswordApi(
      @Query("username") String userName, @Query("password") String password);

  @GET(Apis.aboutUs)
  Future<AboutUsResponse> aboutusApi();

  @GET(Apis.ePaper)
  Future<EPaperResponse> ePaperApi();

  @GET(Apis.newsList)
  Future<NewsListResponse> newsListApi(
      [@Query("CategoryId") String categoryId = '',
      @Query("LocationId") String locationId = '',
      @Query("PageSize") int pageSize = 10,
      @Query("PageNumber") int pageNumber = 1]);

  // @POST('/store')
  // @MultiPart()
  // Future<dynamic> store({
  //   @Part() required String title,
  //   @Part() required int part,
  //   @Part() File? attach,
  // });
}
