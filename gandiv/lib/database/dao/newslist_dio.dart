import 'package:floor/floor.dart';
import '../../models/news_list_db_model.dart';

@dao
abstract class NewsListDao {
  @Query('SELECT * FROM NewsListDB')
  Future<List<NewsListDB>> findAllNews();

  @Query('SELECT * FROM NewsListDB WHERE id = :id')
  Future<NewsListDB?> findNewsById(String id);

  @Query('DELETE FROM NewsListDB WHERE id = :id')
  Future<void> deleteNewsById(String id);

  @insert
  Future<void> insertNews(NewsListDB newsList);
}
