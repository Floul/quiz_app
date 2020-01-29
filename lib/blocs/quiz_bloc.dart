import 'dart:async';
import 'dart:math';

import 'package:flutter/src/foundation/key.dart';
import 'package:quiz_app/blocs/events.dart';
import 'package:quiz_app/database/dao.dart';
import 'package:quiz_app/di/bloc_provider.dart';
import 'package:quiz_app/models/round_stats.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/ui/screens/end_of_the_game_screen.dart';

class QuizBloc extends BlocBase {
  Dao dao = Dao();

  final _repository = Repository();
  final _wordsController = StreamController<List<Word>>();
  final _theWordController = StreamController<Word>();
  final _guessController = StreamController<GuessEvent>.broadcast();
  final _navigationController = StreamController();

  List<Word> _allWords = List();
  int _wordsTaken = 0;
  Word _currentTheWord;
  List<Word> _currentSet;
  int _tries = 0;
  int _round = 0;
  RoundStats _roundStats = RoundStats();
  final _random = new Random();

  get words => _wordsController.stream;

  get theWord => _theWordController.stream;

  get guess => _guessController.stream;

  get navigation => _navigationController.stream;

  QuizBloc() {
    _loadWords();
  }

  Future<void> _loadWords() async {
    _allWords.addAll(await _repository.getWordsForQuiz(20, Word.notPlayed));
    if (_allWords.length < 20) {
      _allWords.addAll(await _repository.getWordsForQuiz(
          20 - _allWords.length, Word.guessedWrong));
    } else if (_allWords.length < 20) {
      _allWords.addAll(await _repository.getWordsForQuiz(
          20 - _allWords.length, Word.guessedRight));
    }
    _allWords.shuffle();
    getNextSet();
  }

  evaluateGuess(Word word, Key key) {
    if (word.original == _currentTheWord.original) {
      guessIsCorrect(key);
    } else {
      _tries++;
      if (_tries < 2) {
        _guessController.sink.add(WrongGuessEvent(key));
      } else {
        _guessController.sink.add(WrongGuessEvent(key));
        guessIsWrong();
      }
    }

//    _tries++;
//    if (_tries < 3) {
//      // do nothing if user wants to tap more than 2 times
//      if (word.original == _currentTheWord.original) {
//        guessIsCorrect(key);
//      } else {
//        if (_tries < 3) {
//          _guessController.sink.add(WrongGuessEvent(key));
//        } else
//          getNextSet();
//      }
//      if (_tries == 2) {
//        guessIsWrong();
//      }
//    }
  }

  void guessIsWrong() {
    _currentTheWord.status = Word.guessedWrong;
    _roundStats.wrongAnswersAmount++;
    dao.update(_currentTheWord);
    getNextSet();
  }

  void guessIsCorrect(Key key) {
    _guessController.sink.add(RightGuessEvent(key));
    _currentTheWord.status = Word.guessedRight;
    _roundStats.correctAnswersAmount++;
    dao.update(_currentTheWord);
    getNextSet();
  }

  Future<void> getNextSet() async {
    await Future.delayed(Duration(milliseconds: 300));
    _round++;
    _tries = 0;
    if (_round < 6) {
      _currentSet = _allWords.skip(_wordsTaken).take(4).toList();
      _wordsTaken += 4;
      _currentTheWord = _currentSet[_random.nextInt(_currentSet.length)];
      _theWordController.sink.add(_currentTheWord);
      _wordsController.sink.add(_currentSet);
    } else {
      endOfTheGame();
    }
  }

  void endOfTheGame() {
    _navigationController.sink.add(EndOfTheGameScreen(_roundStats));
  }

  dispose() {
    _wordsController.close();
    _guessController.close();
    _theWordController.close();
    _navigationController.close();
  }
}

//final quizBloc = QuizBloc();
