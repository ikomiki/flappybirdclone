import 'dart:async';

import 'package:flappybirdclone/barriers.dart';
import 'package:flappybirdclone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  double barrierXOne = 1;
  double barrierXTwo = 1;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    barrierXTwo = barrierXOne + 2;
    initialHeight = 0;
    birdYAxis = 0;
    height = 0;
    time = 0;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3;
        } else {
          barrierXOne -= 0.05;
        }
      });
      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(children: [
                AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(microseconds: 0),
                    color: Colors.blue,
                    child: const MyBird()),
                Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text(" ")
                        : const Text("TAP TO PLAY",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 200)),
                AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 200)),
                AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 150)),
                AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const MyBarrier(size: 250)),
              ])),
          Container(height: 15, color: Colors.green),
          Expanded(
              child: Container(
                  color: Colors.brown,
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SCORE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text("0",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("BEST",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Text("10",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ))
                          ],
                        )
                      ]))),
        ],
      )),
    );
  }
}
