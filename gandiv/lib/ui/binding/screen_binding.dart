import 'package:gandiv/ui/controllers/bookmark_page_controller.dart';
import 'package:gandiv/ui/controllers/dashboard_page_cotroller.dart';
import 'package:gandiv/ui/controllers/e_paper_controller.dart';
import 'package:gandiv/ui/controllers/news_details_page_controller.dart';
import 'package:gandiv/ui/controllers/splash_page_controller.dart';
import 'package:get/instance_manager.dart';
import '../controllers/about_us_page_controller.dart';
import '../controllers/audio_player_page_controller.dart';
import '../controllers/breaking_news_page_controller.dart';
import '../controllers/editorial_news_page_controller.dart';
import '../controllers/home_news_page_controller.dart';
import '../controllers/home_page_contoller.dart';
import '../controllers/search_page_controller.dart';
import '../controllers/video_player_page_controller.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardPageController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SearchPageController());
    Get.lazyPut(() => HomeNewsPageController());
    Get.lazyPut(() => EPaperController());
    Get.lazyPut(() => AboutUsPageController());
    Get.lazyPut(() => BreakingNewsPageController());
    Get.lazyPut(() => EditorialNewsPageController());
    Get.lazyPut(() => SplashPageController());
    Get.lazyPut(() => VideoPlayerPageController());
    Get.lazyPut(() => AudioPlayerPageController());
    Get.lazyPut<BookmarkPageController>(() => BookmarkPageController(),
        fenix: false);
    Get.lazyPut<NewsDetailsPageController>(() => NewsDetailsPageController(),
        fenix: false);
  }
}
