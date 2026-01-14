import 'package:flutter/material.dart';
import 'package:flutter_janken/constants.dart';

class HandButton extends StatelessWidget {
  final void Function(Hand) onHandSelected;
  final Hand hand;

  const HandButton({
    super.key,
    required this.hand,
    required this.onHandSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onHandSelected(hand),
      child: Semantics(
        label: hand.label,
        child: Text(hand.emoji, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
