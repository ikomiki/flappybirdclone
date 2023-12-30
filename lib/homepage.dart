import 'package:flappybirdclone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 2,
            child: Container(
                color: Colors.blue, child: const Center(child: MyBird()))),
        Expanded(
            child: Container(
          color: Colors.green,
        )),
      ],
    ));
  }
}
