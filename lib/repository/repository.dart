import 'package:quiz_app/database/dao.dart';
import 'package:quiz_app/models/word_model.dart';

class Repository {
  final dao = Dao();

  Future<List<Word>> getAllWords() => dao.getAllWords();

  Future insert(Word word) => dao.insert(word);

  Future update(Word word) => dao.update(word);

  Future getById(int id) => dao.getById(id);

  Future getWordsForQuiz(int amount, int status) =>
      dao.getWordsForQuiz(amount, status);
}
