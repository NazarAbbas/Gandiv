import 'package:floor/floor.dart';
import 'package:gandiv/models/news_list_response.dart';

@dao
abstract class NewsListDao {
  @Query('SELECT * FROM NewsList')
  Future<List<NewsList>> findAllNews();

  @Query('SELECT * FROM NewsList WHERE id = :id')
  Future<NewsList?> findNewsById(String id);

  @Query('DELETE FROM NewsList WHERE id = :id')
  Future<void> deleteNewsById(String id);

  @insert
  Future<void> insertNews(NewsList newsList);
}
