import 'package:gandiv/ui/controllers/bookmark_page_controller.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/e_paper_controller.dart';
import 'package:gandiv/ui/controllers/forgot_password_page_controller.dart';
import 'package:gandiv/ui/controllers/news_details_page_controller.dart';
import 'package:gandiv/ui/controllers/profile_page_controller.dart';
import 'package:gandiv/ui/controllers/splash_page_controller.dart';
import 'package:gandiv/ui/controllers/upload_news_page_controller.dart';
import 'package:get/instance_manager.dart';
import '../controllers/about_us_page_controller.dart';
import '../controllers/change_password_page_cotroller.dart';
import '../controllers/edit_profile_page_controller.dart';
import '../controllers/location_page_controller.dart';
import '../controllers/national_news_page_controller.dart';
import '../controllers/home_news_page_controller.dart';
import '../controllers/home_page_contoller.dart';
import '../controllers/international_news_page_controller.dart';
import '../controllers/login_page_cotroller.dart';
import '../controllers/search_page_controller.dart';
import '../controllers/signup_page_cotroller.dart';
import '../controllers/state_news_page_controller.dart';
import '../controllers/video_player_page_controller.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardPageController());
    Get.lazyPut(() => LoginPageController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SearchPageController());
    Get.lazyPut(() => HomeNewsPageController());
    Get.lazyPut(() => StateNewsPageController());
    Get.lazyPut(() => NationalNewsPageController());
    Get.lazyPut(() => InterNationalNewsPageController());
    Get.lazyPut(() => EPaperController());
    Get.lazyPut(() => AboutUsPageController());
    Get.lazyPut(() => SignupPageController());
    Get.lazyPut(() => ProfilePageController());
    Get.lazyPut(() => EditProfilePageController());
    Get.lazyPut(() => UploadNewsPagePageController());
    Get.lazyPut(() => LocationPageController());
    Get.lazyPut(() => SplashPageController());
    Get.lazyPut(() => ForgotPasswordPageController());
    Get.lazyPut(() => ChangePasswordPageController());
    Get.lazyPut(() => VideoPlayerPageController());
    Get.lazyPut<BookmarkPageController>(() => BookmarkPageController(),
        fenix: false);
    Get.lazyPut<NewsDetailsPageController>(() => NewsDetailsPageController(),
        fenix: false);
  }
}
