import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/di/bloc_injection.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/ui/widgets/grid_tile.dart';

class QuizTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: quizBloc.theWord,
        builder: (BuildContext context, AsyncSnapshot<Word> snapshot) {
          if (snapshot.hasData) {
            var theWord = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${theWord.original}",
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: StreamBuilder(
                      stream: quizBloc.words,
                      builder: (context, AsyncSnapshot<List<Word>> snapshot) {
                        var words = snapshot.data;
                        if (snapshot.hasData) {
                          return GridView.builder(
                              itemCount: words.length,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                Word currentWord = words[index];
                                return MyGridTile(currentWord);
                              });
                        } else
                          return CircularProgressIndicator();
                      }),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
