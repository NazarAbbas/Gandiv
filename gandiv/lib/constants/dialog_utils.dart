import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';
import 'package:get/get.dart';

import '../ui/controllers/dashboard_page_cotroller.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();
  static DashboardPageController dashboardPageController =
      Get.find<DashboardPageController>();
  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showThreeButtonCustomDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required String firstButtonText,
      required String secondButtonText,
      required String thirdButtonText,
      required Function firstBtnFunction,
      required Function secondBtnFunction,
      required Function thirdBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.white,
              height: 300,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.colorPrimary,
                        foregroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.black
                                : AppColors.white,
                      ),
                      onPressed: () {
                        firstBtnFunction.call();
                      },
                      child: Text(firstButtonText),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.colorPrimary,
                        foregroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.black
                                : AppColors.white,
                      ),
                      onPressed: () {
                        secondBtnFunction.call();
                      },
                      child: Text(secondButtonText),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.white
                                  : AppColors.colorPrimary,
                          foregroundColor:
                              dashboardPageController.isDarkTheme.value == true
                                  ? AppColors.black
                                  : AppColors.white,
                        ),
                        onPressed: () {
                          thirdBtnFunction.call();
                        },
                        child: Text(thirdButtonText),
                      )),
                ],
              ),
            ),

            // actions: <Widget>[
            //   ElevatedButton(
            //     child: Text(okBtnText),
            //     onPressed: () {
            //       okBtnFunction.call();
            //     },
            //   ),
            //   ElevatedButton(
            //       child: Text(cancelBtnText),
            //       onPressed: () => Navigator.pop(context)),
            //   ElevatedButton(
            //       child: Text(cancelBtnText),
            //       onPressed: () => Navigator.pop(context))
            // ],
          );
        });
  }

  static void showTwoButtonCustomDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required String firstButtonText,
      required String secondButtonText,
      required Function firstBtnFunction,
      required Function secondBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              color: dashboardPageController.isDarkTheme.value == true
                  ? AppColors.dartTheme
                  : AppColors.white,
              height: 200,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.colorPrimary,
                        foregroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.black
                                : AppColors.white,
                      ),
                      onPressed: () {
                        firstBtnFunction.call();
                      },
                      child: Text(firstButtonText),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.white
                                : AppColors.colorPrimary,
                        foregroundColor:
                            dashboardPageController.isDarkTheme.value == true
                                ? AppColors.black
                                : AppColors.white,
                      ),
                      onPressed: () {
                        secondBtnFunction.call();
                      },
                      child: Text(secondButtonText),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
