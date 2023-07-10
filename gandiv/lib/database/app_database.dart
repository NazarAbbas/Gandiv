import 'package:floor/floor.dart';
import 'package:gandiv/models/news_list_response.dart';
import '../models/dashboard_screen_model.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import 'dao/newslist_dio.dart';
import 'media_list_converter.dart';
part 'app_database.g.dart';

//@TypeConverters([MediaListConverter])
@Database(version: 1, entities: [NewsList])
abstract class AppDatabase extends FloorDatabase {
  NewsListDao get newsListDao;
}
