import 'package:flutter/material.dart';
import 'package:gandiv/constants/values/app_colors.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

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
              color: AppColors.white,
              height: 300,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        firstBtnFunction.call();
                      },
                      child: Text(firstButtonText),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        secondBtnFunction.call();
                      },
                      child: Text(secondButtonText),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
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
              color: AppColors.white,
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
                      onPressed: () {
                        firstBtnFunction.call();
                      },
                      child: Text(firstButtonText),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
