import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gandiv/constants/constant.dart';
import 'package:gandiv/network/rest_api.dart';
import 'package:get/get.dart';
import '../../database/app_database.dart';

class DependencyInjection {
  static init() async {
    Get.put<Dio>(Dio()); //initializing Dio
    Get.put<RestAPI>(RestAPI()); //initializing REST API class

    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync<AppDatabase>(permanent: true, () async {
      final db = await $FloorAppDatabase
          .databaseBuilder(Constant.databaseName)
          .build();
      return db;
    });
  }
}
