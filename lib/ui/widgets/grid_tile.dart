import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/events.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/models/word_model.dart';

class MyGridTile extends StatelessWidget {
  final Word currentWord;

  final key = UniqueKey();

  MyGridTile(this.currentWord);

  @override
  Widget build(BuildContext context) {
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
              width: 100,
              height: 100,
              color: tileColor,
              child: Center(
                child: Text(
                  "${currentWord.translated}",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        });
  }
}
