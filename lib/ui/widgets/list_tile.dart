import 'package:flutter/material.dart';
import 'package:quiz_app/models/word_model.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    Key key,
    @required this.word,
  }) : super(key: key);

  final Word word;

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  Color tileColor;

  @override
  void initState() {
    switch (widget.word.status) {
      case Word.notPlayed:
        {
          tileColor = Colors.white;
          break;
        }
      case Word.guessedRight:
        {
          tileColor = Colors.lightGreen;
          break;
        }
      case Word.guessedWrong:
        {
          tileColor = Colors.red;
          break;
        }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(widget.word.image),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.word.original),
                Text(widget.word.translated),
                Text(widget.word.example),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.volume_up), onPressed: null),
            ],
          )
        ],
      ),
    );
  }
}
