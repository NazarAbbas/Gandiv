import 'package:gandiv/route_management/routes.dart';
import 'package:gandiv/ui/binding/screen_binding.dart';
import 'package:gandiv/ui/views/account/edit_profile_page.dart';
import 'package:gandiv/ui/views/account/forgot_password_page.dart';
import 'package:gandiv/ui/views/account/signup_page.dart';
import 'package:gandiv/ui/views/account/upload_news_page.dart';
import 'package:gandiv/ui/views/bottombar_views/profile_page.dart';
import 'package:gandiv/ui/views/dashboard_view/dashboard_page.dart';
import 'package:gandiv/ui/views/e_paper_page.dart';
import 'package:gandiv/ui/views/news_views/news_detail_page.dart';
import 'package:gandiv/ui/views/notification_page.dart';
import 'package:gandiv/ui/views/search_page.dart';
import 'package:gandiv/ui/views/splash_page.dart';
import 'package:get/route_manager.dart';

import '../ui/views/drawer_views/about_us_page.dart';
import '../ui/views/account/login_page.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: Routes.dashboardScreen,
        page: () => DashboardPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => LoginPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.searchPage,
        page: () => SearchPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.notificationPage,
        page: () => const NotificationPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.ePaperPage,
        page: () => const EPaperPage(),
        binding: ScreenBindings(),
      ),
      // GetPage(name: Routes.splashPage, page: () => const SplashPage()),

      GetPage(
          name: Routes.splashPage,
          page: () => const SplashPage(),
          binding: ScreenBindings()),
      GetPage(
          name: Routes.newsDetailPage,
          page: () => const NewsDetailPage(),
          binding: ScreenBindings()),
      GetPage(
        name: Routes.aboutUsPage,
        page: () => AboutUsPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.signupPage,
        page: () => SignupPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.profilePage,
        page: () => ProfilePage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.editProfilePage,
        page: () => EditProfilePage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.uploadNewsPage,
        page: () => UploadNewsPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: Routes.forgotPasswordPage,
        page: () => ForgotPasswordPage(),
        binding: ScreenBindings(),
      )
    ];
  }
}
