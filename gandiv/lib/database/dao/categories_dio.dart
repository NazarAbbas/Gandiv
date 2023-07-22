import 'package:floor/floor.dart';

import '../../models/categories_response.dart';

@dao
abstract class CategoriesDao {
  @Query('SELECT * FROM Categories')
  Future<List<Categories>> findCategories();

  @Query('SELECT * FROM Categories WHERE id = :id')
  Future<Categories?> findCategoriesById(String id);

  @Query('DELETE FROM Categories WHERE id = :id')
  Future<void> deleteCategoriesById(String id);

  @Query('SELECT FROM Categories WHERE name = :name')
  Future<void> deleteCategoriesByName(String name);

  @Query('DELETE FROM Categories')
  Future<void> deleteCategories();

  @insert
  Future<void> insertCategories(Categories categories);
}
