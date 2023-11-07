import 'package:floor/floor.dart';

import '../entity/advertisement_list_db_model.dart';

@dao
abstract class AdvertisementDao {
  @Query('SELECT * FROM AdvertisementDb')
  Future<List<AdvertisementDb>> findAllAdvertisement();

  @Query('SELECT * FROM AdvertisementDb WHERE id = :id')
  Future<AdvertisementDb?> findAdvertisementById(String id);

  @Query('DELETE FROM AdvertisementDb WHERE id = :id')
  Future<void> deleteAdvertisementById(String id);

  @Query('DELETE FROM AdvertisementDb')
  Future<void> deleteAdvertisementDB();

  @insert
  Future<void> insertAdvertisement(AdvertisementDb advertisement);
}
