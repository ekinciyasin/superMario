import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_mario/mario.dart';
import 'package:super_mario/mashrooms.dart';

import 'jumping_mario.dart';
import 'mybutton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //mario variables
  static double marioX = 0;
  static double marioY = 1.02;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;

  //mashrooms variables
  double mashroomX = 0.5;
  double mashroomY = 1;

  void ateMashrooms() {
    if ((marioX - mashroomX).abs() < 0.05 &&
        (marioY - mashroomY).abs() < 0.05) {}
  }

  void preJump() {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    //this first if statement disables the double jump
    if (midjump == false) {
      midjump = true;
      midjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (initialHeight - height > 1.02) {
          midjump = false;
          setState(() {
            marioY = 1.02;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = "right";
    midrun = !midrun;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.yellow,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: Duration(milliseconds: 0),
                    child: midjump
                        ? JumpingMario(
                            direction: direction,
                          )
                        : Mario(
                            direction: direction,
                            midrun: midrun,
                          ),
                  ),
                ),
                Container(
                    alignment: Alignment(mashroomX, mashroomY),
                    child: Mashrooms()),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Zafer'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('00000'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Meryem'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('1-1'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('TIME'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('9999'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    function: moveLeft,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_upward, color: Colors.white),
                    function: jump,
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    function: moveRight,
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
