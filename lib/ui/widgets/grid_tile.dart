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
    Color tileColor = Colors.white;
    double opacity = 1;
    return StreamBuilder<GuessEvent>(
        stream: quizBloc.guess,
        builder: (BuildContext context, AsyncSnapshot<GuessEvent> snapshot) {
          if (snapshot.hasData) {
            GuessEvent event = snapshot.data;
            if (event.key == key) {
              if (event is RightGuessEvent) {
                tileColor = Colors.green;
                opacity = 0.5;
              } else {
                tileColor = Colors.red;
                opacity = 0.5;
              }
            }
          }
          return GestureDetector(
            onTap: () {
              quizBloc.evaluateGuess(currentWord, key);
            },
            child: AnimatedOpacity(
              opacity: opacity,
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
              duration: Duration(milliseconds: 150),
            ),
          );
        });
  }
}
