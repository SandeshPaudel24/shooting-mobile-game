import 'package:flutter/material.dart';

class ball extends StatelessWidget {
  const ball({super.key, this.ballx, this.bally});
  final ballx;
  final bally;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballx, bally),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle),
        color: Colors.lightBlue,
      ),
    );
  }
}
