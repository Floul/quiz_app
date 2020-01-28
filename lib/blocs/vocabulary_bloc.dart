import 'dart:async';

import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/repository/repository.dart';

class VocabularyBloc {
  final _repository = Repository();
  final _wordsController = StreamController<List<Word>>();

  get words => _wordsController.stream;

  VocabularyBloc() {
    _reloadWords();
  }

  _reloadWords() async {
    _wordsController.sink.add(await _repository.getAllWords());
  }

  dispose() {
    _wordsController.close();
  }
}
