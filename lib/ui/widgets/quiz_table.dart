import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/di/bloc_provider.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/ui/widgets/grid_tile.dart';

class QuizTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuizBloc quizBloc = BlocProvider.of(context);
    return StreamBuilder(
        stream: quizBloc.theWord,
        builder: (BuildContext context, AsyncSnapshot<Word> snapshot) {
          if (snapshot.hasData) {
            var theWord = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "${theWord.original}",
                  style: TextStyle(fontSize: 28),
                ),
                Container(
                  width: 300,
                  height: 300,
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
            return CircularProgressIndicator();
          }
        });
  }
}
