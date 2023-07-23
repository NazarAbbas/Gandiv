import 'package:floor/floor.dart';
import 'package:gandiv/models/locations_response.dart';

@dao
abstract class LocationsDao {
  @Query('SELECT * FROM Locations')
  Future<List<Locations>> findLocations();

  @Query('SELECT * FROM Locations WHERE id = :id')
  Future<Locations?> findLocationsById(String id);

  @Query('SELECT * FROM Locations WHERE id = :id')
  Future<Locations?> findLocationsNameById(String id);

  @Query('SELECT * FROM Locations WHERE name = :name')
  Future<Locations?> findLocationsIdByName(String name);

  @Query('DELETE FROM Locations WHERE id = :id')
  Future<void> deleteLocationsById(String id);

  @Query('SELECT FROM Locations WHERE name = :name')
  Future<void> deleteLocationsByName(String name);

  @Query('DELETE FROM Locations')
  Future<void> deleteLocations();

  @insert
  Future<void> insertLocations(Locations locations);
}
