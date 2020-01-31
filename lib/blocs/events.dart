import 'package:equatable/equatable.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:quiz_app/models/word_model.dart';

abstract class GuessStates extends Equatable {
  final key;

  GuessStates(this.key);
}

class WrongGuessState extends GuessStates {
  WrongGuessState(key) : super(key);

  @override
  List<Object> get props => null;
}

class RightGuessState extends GuessStates {
  RightGuessState(key) : super(key);

  @override
  List<Object> get props => null;
}

class GuessEvent extends Equatable {
  final Key key;
  final Word word;

  GuessEvent(this.key, this.word);

  @override
  List<Object> get props => null;
}
