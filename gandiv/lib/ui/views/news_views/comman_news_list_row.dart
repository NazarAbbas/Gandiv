// import 'package:flutter/material.dart';
// import 'package:gandiv/constants/utils.dart';
// import 'package:gandiv/ui/controllers/home_news_page_controller.dart';
// import 'package:get/get.dart';
// import 'package:share/share.dart';
// import '../../../constants/values/app_colors.dart';
// import '../../../constants/values/app_images.dart';
// import '../../../models/news_list_response.dart';
// import '../../../route_management/routes.dart';
// import '../../controllers/dashboard_page_cotroller.dart';

// // ignore: must_be_immutable
// class CommanNewsListRow extends StatelessWidget {
//   DashboardPageController dashboardPageController =
//       Get.find<DashboardPageController>();

//   HomeNewsPageController homeNewsController =
//       Get.find<HomeNewsPageController>();
//   final List<NewsList> newsList;

//   CommanNewsListRow({
//     super.key,
//     required this.newsList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: newsList.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//             onTap: () => {Get.toNamed(Routes.newsDetailPage)},
//             child: rowWidget(index, context));
//       },
//     );
//   }

//   Obx rowWidget(int index, BuildContext context) {
//     return Obx(
//       () => Card(
//         color: dashboardPageController.isDarkTheme.value == true
//             ? AppColors.dartTheme
//             : AppColors.white,
//         elevation: 8.0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   newsList[index].heading!,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   newsList[index].newsContent!,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: dashboardPageController.isDarkTheme.value == true
//                         ? AppColors.white
//                         : AppColors.black,
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               // child: Image.network(
//               //   newsList[index].mediaList == null
//               //       ? 'https://avatars.githubusercontent.com/u/1?v=4"'
//               //       : newsList[index].mediaList!,
//               child: Image.network(
//                 'https://avatars.githubusercontent.com/u/1?v=4',
//                 height: MediaQuery.of(context).size.width * (3 / 4),
//                 width: MediaQuery.of(context).size.width,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded /
//                               loadingProgress.expectedTotalBytes!
//                           : null,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Center(
//                     child: Image.asset(
//                       color: dashboardPageController.isDarkTheme.value == true
//                           ? AppColors.white
//                           : AppColors.black,
//                       AppImages.clock,
//                       height: 20,
//                       width: 20,
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       '5 mins read',
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: dashboardPageController.isDarkTheme.value == true
//                             ? AppColors.white
//                             : AppColors.black,
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: () {
//                       if (newsList[index].isAudioPlaying == true) {
//                         Utils(context).stopAudio(newsList[index].newsContent!);
//                         homeNewsController.setAudioPlaying(false, index);
//                       } else {
//                         Utils(context).startAudio(newsList[index].newsContent!);
//                         homeNewsController.setAudioPlaying(true, index);
//                       }
//                     },
//                     child: Image.asset(
//                       color: dashboardPageController.isDarkTheme.value == true
//                           ? newsList[index].isAudioPlaying == true
//                               ? AppColors.colorPrimary
//                               : AppColors.white
//                           : newsList[index].isAudioPlaying == true
//                               ? AppColors.colorPrimary
//                               : AppColors.black,
//                       AppImages.audio,
//                       width: 30,
//                       height: 30,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         if (newsList[index].isBookmark == true) {
//                           homeNewsController.setBookmark(index);
//                         } else {
//                           homeNewsController.removeBookmark(index);
//                         }
//                       },
//                       child: Image.asset(
//                         color: dashboardPageController.isDarkTheme.value == true
//                             ? AppColors.white
//                             : AppColors.colorPrimary,
//                         newsList[index].isBookmark == true
//                             ? AppImages.highLightBookmark
//                             : AppImages.bookmark,
//                         width: 25,
//                         height: 25,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: GestureDetector(
//                       onTap: () {
//                         Share.share('check out my website https://example.com');
//                       },
//                       child: Image.asset(
//                         color: dashboardPageController.isDarkTheme.value == true
//                             ? AppColors.white
//                             : AppColors.black,
//                         AppImages.share,
//                         width: 25,
//                         height: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
