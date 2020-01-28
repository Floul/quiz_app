import 'package:equatable/equatable.dart';
import 'package:flutter/src/foundation/key.dart';

abstract class GuessEvent extends Equatable {
  final key;

  GuessEvent(this.key);
}

class WrongGuessEvent extends GuessEvent {
  WrongGuessEvent(key) : super(key);

  @override
  List<Object> get props => null;
}

class RightGuessEvent extends GuessEvent {
  RightGuessEvent(key) : super(key);

  @override
  List<Object> get props => null;
}
