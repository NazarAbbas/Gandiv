import 'package:floor/floor.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gandiv/database/dao/categories_dio.dart';
import 'package:gandiv/database/dao/locations_dio.dart';
import 'package:gandiv/database/dao/profile_dio.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:gandiv/models/locations_response.dart';
import 'package:gandiv/models/profile_db_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import '../models/news_list_db_model.dart';
import 'dao/newslist_dio.dart';
import 'media_list_converter.dart';
part 'app_database.g.dart';

@Database(
    version: 1, entities: [NewsListDB, ProfileData, Categories, Locations])
abstract class AppDatabase extends FloorDatabase {
  NewsListDao get newsListDao;
  ProfileDao get profileDao;
  CategoriesDao get categoriesDao;
  LocationsDao get locationsDao;
}
