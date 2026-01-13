import 'dart:math';

enum GameResult {
  win('勝ち'),
  lose('負け'),
  draw('引き分け');

  const GameResult(this.label);

  final String label;
}

enum Hand {
  rock("✊", 'グー'),
  scissors("✌️", 'チョキ'),
  paper("🖐", 'パー');

  const Hand(this.emoji, this.label);

  final String emoji;
  final String label;

  static final Random _random = Random();

  static Hand random() {
    final randomNumber = _random.nextInt(Hand.values.length);
    return Hand.values[randomNumber];
  }

  GameResult judge(Hand other) {
    if (this == other) {
      return GameResult.draw;
    } else if ((this == Hand.rock && other == Hand.scissors) ||
        (this == Hand.scissors && other == Hand.paper) ||
        (this == Hand.paper && other == Hand.rock)) {
      return GameResult.win;
    } else {
      return GameResult.lose;
    }
  }
}
