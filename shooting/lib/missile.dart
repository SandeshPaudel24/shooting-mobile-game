import 'package:flutter/material.dart';

class Missle extends StatelessWidget {
  const Missle({super.key, this.missilex, this.height});
  final missilex;
  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missilex, 1),
      child: Container(
        width: 2,
        height: height,
        color: Colors.black26,
      ),
    );
  }
}
