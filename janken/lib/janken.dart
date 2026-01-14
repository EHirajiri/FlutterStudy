import 'package:flutter/material.dart';
import 'package:flutter_janken/constants.dart';
import 'package:flutter_janken/hand_button.dart';

class JankenPage extends StatefulWidget {
  const JankenPage({super.key, required this.title});

  final String title;

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  int count = 0;
  int winCount = 0;
  Hand myHand = Hand.rock;
  Hand computerHand = Hand.rock;
  GameResult? result;

  void selectHand(Hand selectedHand) {
    setState(() {
      myHand = selectedHand;
      computerHand = Hand.random;
      result = GameResult.values[myHand.compareTo(computerHand)];
      count++;
      winCount += result == GameResult.win ? 1 : 0;
    });

    if (count >= 5) {
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('5回勝負終了！'),
        content: Text('あなたの勝利数は $winCount 回です。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                count = 0;
                winCount = 0;
                result = null;
                myHand = Hand.rock;
                computerHand = Hand.rock;
              });
            },
            child: const Text('もう一度'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: '結果: ${result?.label ?? '5回勝負！手を選んでください'}',
              child: Text(
                result?.label ?? '5回勝負！',
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 48),
            Semantics(
              label: 'コンピュータの手: ${computerHand.label}',
              child: Text(computerHand.emoji, style: TextStyle(fontSize: 48)),
            ),
            SizedBox(height: 48),
            Semantics(
              label: 'あなたの手: ${myHand.label}',
              child: Text(myHand.emoji, style: TextStyle(fontSize: 48)),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Hand.values
                  .map(
                    (hand) =>
                        HandButton(hand: hand, onHandSelected: selectHand),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
