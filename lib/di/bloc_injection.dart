import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/blocs/vocabulary_bloc.dart';

class BlocInjection extends InheritedWidget {
  final vocabularyBloc;
  final quizBloc;

  BlocInjection({this.vocabularyBloc, this.quizBloc, Widget child})
      : super(child: child);

  static VocabularyBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BlocInjection>())
        .vocabularyBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
