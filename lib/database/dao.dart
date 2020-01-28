import 'package:quiz_app/database/app_database.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:sembast/sembast.dart';

class Dao {
  static const String STORE_NAME = "words";
  final wordStore = StoreRef(STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Word word) async {
    wordStore.add(await _db, word.toMap());
  }

  Future update(Word word) async {
    final finder = Finder(filter: Filter.byKey(word.id));

    await wordStore.update(await _db, word.toMap(), finder: finder);
  }

  Future<Word> getById(int id) async {
    final finder = Finder(filter: Filter.byKey(id));
    final snapshot = await wordStore.findFirst(await _db, finder: finder);
    return Word.fromMap(snapshot.key, snapshot.value);
  }

  Future delete(Word word) async {
    final finder = Finder(filter: Filter.byKey(word.id));
    wordStore.delete(await _db, finder: finder);
  }

  Future<List<Word>> getAllWords() async {
    final snapshot = await wordStore.find(await _db);
    return snapshot.map((map) {
      return Word.fromMap(map.key, map.value);
    }).toList();
  }

  Future<List<Word>> getWordsForQuiz(int amount, int status) async {
    Finder finder = Finder(filter: Filter.equals("status", status));
    final snapshot = await wordStore.find(
      await _db,
    );
    return snapshot.map((map) {
      return Word.fromMap(map.key, map.value);
    }).toList();
  }
}
