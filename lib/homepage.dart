import 'dart:async';

import 'package:flappybirdclone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
              onTap: () {
                if (gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: Duration(microseconds: 0),
                  color: Colors.blue,
                  child: MyBird())),
        ),
        Container(height: 15, color: Colors.green),
        Expanded(
            child: Container(
                color: Colors.brown,
                child: Row(
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
    ));
  }
}
