import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton accessor
  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Sembast database object
  Database _database;

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'demo.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    // Any code awaiting the Completer's future will now start executing
    var store = intMapStoreFactory.store("words");
    await insertFakeData(database, store);
    _dbOpenCompleter.complete(database);
  }

  Future insertFakeData(
      Database db, StoreRef<int, Map<String, dynamic>> store) async {
    await store.drop(db);
    await store.addAll(db, [
      Word(
        'Hello',
        'Привіт',
        'Привіт, як справи?',
        'assets/images/image_placeholder.png',
        'assets/images/image_placeholder.png',
      ).toMap(),
      Word(
              'Dog',
              'Пес',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Apple',
              'Яблуко',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Yellow',
              'Жовтий',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Red',
              'Червоний',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Green',
              'Зелений',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Water',
              'Вода',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Table',
              'Стіл',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'See',
              'Бачити',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Tomorrow',
              'Привіт',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Seven',
              'Сім',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Run',
              'Бігти',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Folder',
              'Тека',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Chair',
              'Стілець',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Cup',
              'Чашка',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Fork',
              'Виделка',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Glass',
              'Скло',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Window',
              'Вікно',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Door',
              'Двері',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
      Word(
              'Cat',
              'Кіт',
              'Привіт, як справи?',
              'assets/images/image_placeholder.png',
              'assets/images/image_placeholder.png')
          .toMap(),
    ]);
  }
}
