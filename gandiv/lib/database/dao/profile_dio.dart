import 'package:floor/floor.dart';

import '../../models/profile_db_model.dart';

@dao
abstract class ProfileDao {
  @Query('SELECT * FROM ProfileData')
  Future<List<ProfileData>> findProfile();

  @Query('SELECT * FROM ProfileData WHERE id = :id')
  Future<ProfileData?> findProfileById(String id);

  @Query('DELETE FROM ProfileData WHERE id = :id')
  Future<void> deleteProfileById(String id);

  @insert
  Future<void> insertProfile(ProfileData profileData);
}
