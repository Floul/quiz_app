import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/blocs/quiz_bloc.dart';
import 'package:quiz_app/di/bloc_provider.dart';
import 'package:quiz_app/models/word_model.dart';
import 'package:quiz_app/ui/widgets/quiz_table.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  StreamSubscription _streamSubscription;
  QuizBloc quizBloc = QuizBloc();
  @override
  void initState() {
    _listen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: quizBloc,
        child: SafeArea(
          child: Center(child: QuizTable()),
        ),
      ),
    );
  }

  void _listen() {
    _streamSubscription = quizBloc.navigation.listen((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => value));
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
