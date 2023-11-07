import 'package:floor/floor.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gandiv/database/dao/categories_dio.dart';
import 'package:gandiv/database/dao/locations_dio.dart';
import 'package:gandiv/models/categories_response.dart';
import 'package:gandiv/models/locations_response.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import '../models/news_list_db_model.dart';
import 'dao/advertisement_dio.dart';
import 'dao/newslist_dio.dart';
import 'entity/advertisement_list_db_model.dart';
import 'media_list_converter.dart';
part 'app_database.g.dart';

@Database(
    version: 1, entities: [NewsListDB, Categories, Locations, AdvertisementDb])
abstract class AppDatabase extends FloorDatabase {
  NewsListDao get newsListDao;
  CategoriesDao get categoriesDao;
  LocationsDao get locationsDao;
  AdvertisementDao get advertisementDao;
}
