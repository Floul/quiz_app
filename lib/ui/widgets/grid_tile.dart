import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/events.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/di/bloc_provider.dart';
import 'package:quiz_app/models/word_model.dart';

class MyGridTile extends StatelessWidget {
  final Word currentWord;

  final key = UniqueKey();

  MyGridTile(this.currentWord);

  @override
  Widget build(BuildContext context) {
    QuizBloc quizBloc = BlocProvider.of(context);
    var tileColor = Colors.white;
    return StreamBuilder<GuessEvent>(
        stream: quizBloc.guess,
        builder: (BuildContext context, AsyncSnapshot<GuessEvent> snapshot) {
          if (snapshot.hasData) {
            GuessEvent event = snapshot.data;
            if (event.key == key) {
              if (event is RightGuessEvent) {
                tileColor = Colors.green;
              } else {
                tileColor = Colors.red;
              }
            }
          }
          return GestureDetector(
            onTap: () {
              quizBloc.evaluateGuess(currentWord, key);
            },
            child: Container(
              color: tileColor,
              child: Column(
                children: <Widget>[
                  Image.asset(currentWord.image),
                  Center(
                    child: Text(
                      "${currentWord.translated}",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
