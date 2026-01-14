import 'dart:math';

enum GameResult {
  win('勝ち'),
  lose('負け'),
  draw('引き分け');

  const GameResult(this.label);

  final String label;
}

enum Hand implements Comparable<Hand> {
  rock("✊", 'グー'),
  scissors("✌️", 'チョキ'),
  paper("🖐", 'パー');

  const Hand(this.emoji, this.label);

  final String emoji;
  final String label;

  static Hand get random => Hand.values[Random().nextInt(Hand.values.length)];

  @override
  int compareTo(Hand other) {
    if (this == other) {
      return GameResult.draw.index;
    } else if ((this == Hand.rock && other == Hand.scissors) ||
        (this == Hand.scissors && other == Hand.paper) ||
        (this == Hand.paper && other == Hand.rock)) {
      return GameResult.win.index;
    } else {
      return GameResult.lose.index;
    }
  }
}
