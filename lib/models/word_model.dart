class Word {
  static const int guessedRight = 2;
  static const int guessedWrong = 1;
  static const int notPlayed = 0;

  int id;

  String original;

  String translated;

  String example;

  String image;

  String audio;

  int status;

  Word(this.original, this.translated, this.example, this.image, this.audio,
      {this.id, this.status = Word.notPlayed});

  Map<String, dynamic> toMap() {
    return {
      'original': original,
      'translated': translated,
      'example': example,
      'image': image,
      'audio': audio,
      'status': status,
    };
  }

  static Word fromMap(int id, Map<String, dynamic> map) {
    return Word(map["original"], map["translated"], map["example"],
        map["image"], map["audio"],
        id: id, status: map["status"]);
  }
}
