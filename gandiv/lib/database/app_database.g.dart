// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NewsListDao? _newsListDaoInstance;

  ProfileDao? _profileDaoInstance;

  CategoriesDao? _categoriesDaoInstance;

  LocationsDao? _locationsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NewsListDB` (`id` TEXT, `heading` TEXT, `subHeading` TEXT, `newsContent` TEXT, `category` TEXT, `location` TEXT, `language` TEXT, `imageListDb` TEXT, `videoListDb` TEXT, `audioListDb` TEXT, `publishedOn` TEXT, `publishedBy` TEXT, `isBookmark` INTEGER, `isAudioPlaying` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProfileData` (`id` TEXT, `title` TEXT, `firstName` TEXT, `lastName` TEXT, `mobileNo` TEXT, `email` TEXT, `gender` TEXT, `profileImage` TEXT, `role` TEXT, `token` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Categories` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Locations` (`id` TEXT, `name` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsListDao get newsListDao {
    return _newsListDaoInstance ??= _$NewsListDao(database, changeListener);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  CategoriesDao get categoriesDao {
    return _categoriesDaoInstance ??= _$CategoriesDao(database, changeListener);
  }

  @override
  LocationsDao get locationsDao {
    return _locationsDaoInstance ??= _$LocationsDao(database, changeListener);
  }
}

class _$NewsListDao extends NewsListDao {
  _$NewsListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _newsListDBInsertionAdapter = InsertionAdapter(
            database,
            'NewsListDB',
            (NewsListDB item) => <String, Object?>{
                  'id': item.id,
                  'heading': item.heading,
                  'subHeading': item.subHeading,
                  'newsContent': item.newsContent,
                  'category': item.category,
                  'location': item.location,
                  'language': item.language,
                  'imageListDb': item.imageListDb,
                  'videoListDb': item.videoListDb,
                  'audioListDb': item.audioListDb,
                  'publishedOn': item.publishedOn,
                  'publishedBy': item.publishedBy,
                  'isBookmark': item.isBookmark == null
                      ? null
                      : (item.isBookmark! ? 1 : 0),
                  'isAudioPlaying': item.isAudioPlaying == null
                      ? null
                      : (item.isAudioPlaying! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NewsListDB> _newsListDBInsertionAdapter;

  @override
  Future<List<NewsListDB>> findAllNews() async {
    return _queryAdapter.queryList('SELECT * FROM NewsListDB',
        mapper: (Map<String, Object?> row) => NewsListDB(
            id: row['id'] as String?,
            heading: row['heading'] as String?,
            subHeading: row['subHeading'] as String?,
            newsContent: row['newsContent'] as String?,
            category: row['category'] as String?,
            location: row['location'] as String?,
            language: row['language'] as String?,
            imageListDb: row['imageListDb'] as String?,
            videoListDb: row['videoListDb'] as String?,
            audioListDb: row['audioListDb'] as String?,
            publishedOn: row['publishedOn'] as String?,
            publishedBy: row['publishedBy'] as String?,
            isBookmark: row['isBookmark'] == null
                ? null
                : (row['isBookmark'] as int) != 0,
            isAudioPlaying: row['isAudioPlaying'] == null
                ? null
                : (row['isAudioPlaying'] as int) != 0));
  }

  @override
  Future<NewsListDB?> findNewsById(String id) async {
    return _queryAdapter.query('SELECT * FROM NewsListDB WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NewsListDB(
            id: row['id'] as String?,
            heading: row['heading'] as String?,
            subHeading: row['subHeading'] as String?,
            newsContent: row['newsContent'] as String?,
            category: row['category'] as String?,
            location: row['location'] as String?,
            language: row['language'] as String?,
            imageListDb: row['imageListDb'] as String?,
            videoListDb: row['videoListDb'] as String?,
            audioListDb: row['audioListDb'] as String?,
            publishedOn: row['publishedOn'] as String?,
            publishedBy: row['publishedBy'] as String?,
            isBookmark: row['isBookmark'] == null
                ? null
                : (row['isBookmark'] as int) != 0,
            isAudioPlaying: row['isAudioPlaying'] == null
                ? null
                : (row['isAudioPlaying'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteNewsById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM NewsListDB WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertNews(NewsListDB newsList) async {
    await _newsListDBInsertionAdapter.insert(
        newsList, OnConflictStrategy.abort);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileDataInsertionAdapter = InsertionAdapter(
            database,
            'ProfileData',
            (ProfileData item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'mobileNo': item.mobileNo,
                  'email': item.email,
                  'gender': item.gender,
                  'profileImage': item.profileImage,
                  'role': item.role,
                  'token': item.token
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProfileData> _profileDataInsertionAdapter;

  @override
  Future<List<ProfileData>> findProfile() async {
    return _queryAdapter.queryList('SELECT * FROM ProfileData',
        mapper: (Map<String, Object?> row) => ProfileData(
            id: row['id'] as String?,
            title: row['title'] as String?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            mobileNo: row['mobileNo'] as String?,
            email: row['email'] as String?,
            gender: row['gender'] as String?,
            profileImage: row['profileImage'] as String?,
            role: row['role'] as String?,
            token: row['token'] as String?));
  }

  @override
  Future<ProfileData?> findProfileById(String id) async {
    return _queryAdapter.query('SELECT * FROM ProfileData WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProfileData(
            id: row['id'] as String?,
            title: row['title'] as String?,
            firstName: row['firstName'] as String?,
            lastName: row['lastName'] as String?,
            mobileNo: row['mobileNo'] as String?,
            email: row['email'] as String?,
            gender: row['gender'] as String?,
            profileImage: row['profileImage'] as String?,
            role: row['role'] as String?,
            token: row['token'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteProfileById(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM ProfileData WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProfile(ProfileData profileData) async {
    await _profileDataInsertionAdapter.insert(
        profileData, OnConflictStrategy.abort);
  }
}

class _$CategoriesDao extends CategoriesDao {
  _$CategoriesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _categoriesInsertionAdapter = InsertionAdapter(
            database,
            'Categories',
            (Categories item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Categories> _categoriesInsertionAdapter;

  @override
  Future<List<Categories>> findCategories() async {
    return _queryAdapter.queryList('SELECT * FROM Categories',
        mapper: (Map<String, Object?> row) =>
            Categories(id: row['id'] as String, name: row['name'] as String));
  }

  @override
  Future<Categories?> findCategoriesById(String id) async {
    return _queryAdapter.query('SELECT * FROM Categories WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Categories(id: row['id'] as String, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteCategoriesById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Categories WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteCategoriesByName(String name) async {
    await _queryAdapter.queryNoReturn('SELECT FROM Categories WHERE name = ?1',
        arguments: [name]);
  }

  @override
  Future<void> deleteCategories() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Categories');
  }

  @override
  Future<void> insertCategories(Categories categories) async {
    await _categoriesInsertionAdapter.insert(
        categories, OnConflictStrategy.abort);
  }
}

class _$LocationsDao extends LocationsDao {
  _$LocationsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _locationsInsertionAdapter = InsertionAdapter(
            database,
            'Locations',
            (Locations item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Locations> _locationsInsertionAdapter;

  @override
  Future<List<Locations>> findLocations() async {
    return _queryAdapter.queryList('SELECT * FROM Locations',
        mapper: (Map<String, Object?> row) =>
            Locations(id: row['id'] as String?, name: row['name'] as String?));
  }

  @override
  Future<Locations?> findLocationsById(String id) async {
    return _queryAdapter.query('SELECT * FROM Locations WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Locations(id: row['id'] as String?, name: row['name'] as String?),
        arguments: [id]);
  }

  @override
  Future<Locations?> findLocationsNameById(String id) async {
    return _queryAdapter.query('SELECT name FROM Locations WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Locations(id: row['id'] as String?, name: row['name'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteLocationsById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Locations WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteLocationsByName(String name) async {
    await _queryAdapter.queryNoReturn('SELECT FROM Locations WHERE name = ?1',
        arguments: [name]);
  }

  @override
  Future<void> deleteLocations() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Locations');
  }

  @override
  Future<void> insertLocations(Locations locations) async {
    await _locationsInsertionAdapter.insert(
        locations, OnConflictStrategy.abort);
  }
}
