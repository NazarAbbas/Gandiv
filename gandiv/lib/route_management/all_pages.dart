import 'package:gandiv/route_management/routes.dart';
import 'package:gandiv/ui/binding/screen_binding.dart';
import 'package:gandiv/ui/views/dashboard_view/dashboard_page.dart';
import 'package:gandiv/ui/views/e_paper_page.dart';
import 'package:gandiv/ui/views/news_views/news_detail_page.dart';
import 'package:gandiv/ui/views/news_views/video_player_page.dart';
import 'package:gandiv/ui/views/notification_page.dart';
import 'package:gandiv/ui/views/search_page.dart';
import 'package:gandiv/ui/views/splash_page.dart';
import 'package:get/route_manager.dart';
import '../ui/views/drawer_views/about_us_page.dart';
import '../ui/views/news_views/audio_player_page.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: Routes.dashboardScreen,
        page: () => const DashboardPage(),
        binding: ScreenBindings(),
        // transitionDuration: const Duration(
        //     milliseconds: 300), //duration of transitions, default 1 sec
        transition: Transition.cupertino,
      ),
      GetPage(
          name: Routes.searchPage,
          page: () => const SearchPage(),
          binding: ScreenBindings(),
          transition: Transition.downToUp),
      GetPage(
          name: Routes.notificationPage,
          page: () => const NotificationPage(),
          binding: ScreenBindings(),
          transition: Transition.cupertino),
      GetPage(
        name: Routes.ePaperPage,
        page: () => EPaperPage(),
        binding: ScreenBindings(),
        // transitionDuration: const Duration(
        //     milliseconds: 300), //duration of transitions, default 1 sec
        transition: Transition.cupertino,
      ),
      GetPage(
          name: Routes.splashPage,
          page: () => const SplashPage(),
          binding: ScreenBindings(),
          transition: Transition.zoom),
      GetPage(
          name: Routes.newsDetailPage,
          page: () => const NewsDetailPage(),
          binding: ScreenBindings(),
          transition: Transition.zoom),
      GetPage(
          name: Routes.aboutUsPage,
          page: () => AboutUsPage(),
          binding: ScreenBindings(),
          // transitionDuration: const Duration(
          //     milliseconds: 300), //duration of transitions, default 1 sec
          transition: Transition.cupertino),
      GetPage(
          name: Routes.videoPlayerPage,
          page: () => const VideoPlayerPage(),
          binding: ScreenBindings(),
          transition: Transition.zoom),
      GetPage(
          name: Routes.audioPlayerPage,
          page: () => const AudioPlayerPage(),
          binding: ScreenBindings(),
          transition: Transition.zoom)
    ];
  }
}
