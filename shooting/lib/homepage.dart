import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shooting/ball.dart';
import 'package:shooting/button.dart';
import 'package:shooting/missile.dart';
import 'package:shooting/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => __HomePageState();
}

// for ball control using enum
enum direction { left, right }

class __HomePageState extends State<HomePage> {
  // player variable
  static double player = 0;

  //missile
  double missilex = player;
  double missileheight = 10;
  bool shot = false;

//ball
  double ballx = 0.5;
  double bally = 0;
  var balld = direction.left;

  bool playerdead() {
    if ((ballx - player).abs() < 0.05 && bally > 0.9) {
      return true;
    } else {
      return false;
    }
  }

//for ball popping equation
  double hCordinate(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double postion = 1 - 2 * height / totalHeight;
    return postion;
  }

// start game
  void start() {
    double time = 0;
    double height = 0;
    double velocity = 60;

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      height = -5 * time * time * velocity + 100 * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        bally = hCordinate(height);
      });
      if (ballx - 0.005 < -1) {
        balld = direction.right;
      } else if (ballx + 0.005 > 1) {
        balld = direction.left;
      }
      if (balld == direction.left) {
        setState(() {
          ballx -= 0.005;
        });
      } else if (balld == direction.right) {
        ballx += 0.005;
      }

      //check player
      if (playerdead()) {
        timer.cancel();
        _showdialog();
      }

      time += 0.1;
    });
  }

  void _showdialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Player Dead", style: TextStyle(color: Colors.white)),
          );
        });
  }

  void resetMissile() {
    missilex = player;
    missileheight = 10;
    shot = false;
  }

  //for left
  void moveleft() {
    setState(() {
      if (player - 0.1 < -1) {
        // nothing
      } else {
        player -= 0.1;
      }

      if (shot) {
        missilex = player;
      }
    });
  }

//for right
  void moveright() {
    setState(() {
      if (player + 0.1 > 1) {
        //nothing
      } else {
        player += 0.1;
      }
      missilex = player;
    });
  }

  void firemissile() {
    if (shot == false) {
      Timer.periodic(Duration(milliseconds: 20), (timer) {
        shot = true;
        setState(() {
          missileheight += 10;
        });
        setState(() {
          // return fire to zero
          if (missileheight > MediaQuery.of(context).size.height * 3 / 4) {
            resetMissile();
            timer.cancel();
            shot = false;
          }
          // missle hit ball
          if (bally > hCordinate(missileheight) &&
              (ballx - missileheight).abs() < 0.03) {
            resetMissile();
            bally = 5;
            timer.cancel();
          }
          ;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[300],
              ),
              child: Center(
                child: Stack(
                  children: [
                    ball(
                      ballx: ballx,
                      bally: bally,
                    ),
                    Missle(
                      height: missileheight,
                      missilex: missilex,
                    ),
                    Myplayer(
                      player: player,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    icon: Icons.play_arrow,
                    // function:
                  ),
                  MyButton(
                    icon: Icons.arrow_back,
                    function: moveleft,
                  ),
                  MyButton(
                    icon: Icons.arrow_upward,
                    function: firemissile,
                  ),
                  MyButton(
                    icon: Icons.arrow_forward,
                    function: moveright,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
