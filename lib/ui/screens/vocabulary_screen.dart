import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/vocabulary_bloc.dart';
import 'package:quiz_app/di/bloc_injection.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/ui/screens/quiz_screen.dart';
import 'package:quiz_app/ui/widgets/list_tile.dart';

class VocabularyScreen extends StatefulWidget {
  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  VocabularyBloc vocabularyBloc;

  @override
  void initState() {
    vocabularyBloc = VocabularyBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder(
          stream: vocabularyBloc.words,
          builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
            if (snapshot.data != null) {
              List<Word> words = snapshot.data;
              return ListView.builder(
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    Word word = words[index];
                    return MyListTile(
                      word: word,
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QuizScreen()));
        },
        label: Text(
          "Start",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    vocabularyBloc.dispose();
    super.dispose();
  }
}
