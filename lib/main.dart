import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/blocs/vocabulary_bloc.dart';
import 'package:quiz_app/database/dao.dart';
import 'package:quiz_app/di/bloc_injection.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/ui/screens/quiz_screen.dart';
import 'package:quiz_app/ui/screens/vocabulary_screen.dart';
import 'package:quiz_app/ui/widgets/list_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocInjection(
      vocabularyBloc: VocabularyBloc(),
      quizBloc: QuizBloc(),
      child: MaterialApp(
        title: 'Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: VocabularyScreen(),
      ),
    );
  }
}
