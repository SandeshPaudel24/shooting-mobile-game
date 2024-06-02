import 'package:flutter/material.dart';

class Myplayer extends StatelessWidget {
  const Myplayer({super.key, this.player});

  final player;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(player, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.deepOrange,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
