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
            'CREATE TABLE IF NOT EXISTS `NewsList` (`id` TEXT, `heading` TEXT, `subHeading` TEXT, `newsContent` TEXT, `category` TEXT, `location` TEXT, `language` TEXT, `publishedOn` TEXT, `publishedBy` TEXT, `isBookmark` INTEGER, `isAudioPlaying` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsListDao get newsListDao {
    return _newsListDaoInstance ??= _$NewsListDao(database, changeListener);
  }
}

class _$NewsListDao extends NewsListDao {
  _$NewsListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _newsListInsertionAdapter = InsertionAdapter(
            database,
            'NewsList',
            (NewsList item) => <String, Object?>{
                  'id': item.id,
                  'heading': item.heading,
                  'subHeading': item.subHeading,
                  'newsContent': item.newsContent,
                  'category': item.category,
                  'location': item.location,
                  'language': item.language,
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

  final InsertionAdapter<NewsList> _newsListInsertionAdapter;

  @override
  Future<List<NewsList>> findAllNews() async {
    return _queryAdapter.queryList('SELECT * FROM NewsList',
        mapper: (Map<String, Object?> row) => NewsList(
            id: row['id'] as String?,
            heading: row['heading'] as String?,
            subHeading: row['subHeading'] as String?,
            newsContent: row['newsContent'] as String?,
            category: row['category'] as String?,
            location: row['location'] as String?,
            language: row['language'] as String?,
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
  Future<NewsList?> findNewsById(String id) async {
    return _queryAdapter.query('SELECT * FROM NewsList WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NewsList(
            id: row['id'] as String?,
            heading: row['heading'] as String?,
            subHeading: row['subHeading'] as String?,
            newsContent: row['newsContent'] as String?,
            category: row['category'] as String?,
            location: row['location'] as String?,
            language: row['language'] as String?,
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
        .queryNoReturn('DELETE FROM NewsList WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertNews(NewsList newsList) async {
    await _newsListInsertionAdapter.insert(newsList, OnConflictStrategy.abort);
  }
}
