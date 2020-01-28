import 'package:flutter/material.dart';
import 'package:quiz_app/models/round_stats.dart';
import 'package:quiz_app/ui/screens/vocabulary_screen.dart';

class EndOfTheGameScreen extends StatelessWidget {
  final RoundStats roundStats;

  EndOfTheGameScreen(this.roundStats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Correct answers: ${roundStats.correctAnswersAmount}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Wrong answers: ${roundStats.wrongAnswersAmount}",
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => VocabularyScreen()),
              (Route<dynamic> route) => false);
        },
        label: Text(
          "Start",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
