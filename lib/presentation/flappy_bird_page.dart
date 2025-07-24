import 'dart:math';

import 'package:flutter/material.dart';

class FlappyBirdPage extends StatefulWidget {
  const FlappyBirdPage({super.key});

  @override
  State<FlappyBirdPage> createState() => _FlappyBirdPageState();
}

class _FlappyBirdPageState extends State<FlappyBirdPage> {
  final birdSize = 50.0;
  final pipeWidth = 60.0;

  double pipeHeightTop = 200.0;
  double pipeHeightBottom = 200.0;
  double pipeX = 300.0;
  double pipeSpace = 150;

  double widthPage = 0;
  double heightPage = 0;

  double birdX = 0;
  double birdY = 0;

  double gravity = 15; // gia tốc
  double velocity = 0; // vận tốc ban đầu

  bool isStartGame = false;
  bool isEndGame = false;

  @override
  void initState() {
    super.initState();
  }

  Future startGame() async {
    widthPage = MediaQuery.of(context).size.width;
    heightPage = MediaQuery.of(context).size.height;
    birdX = (widthPage / 2) - (birdSize / 2);
    birdY = (heightPage / 2) - (birdSize / 2);
    isStartGame = true;
    isEndGame = false;

    pipeX = 300.0;

    setState(() {});
    fallBird();
    runPipeS();
  }

  Future runPipeS() async {
    if (isEndGame) {
      setState(() {});
      return;
    }
    await Future.delayed(const Duration(milliseconds: 150));
    pipeX -= 7.5;
    if (pipeX + pipeWidth < 0) {
      pipeX = widthPage;
      pipeHeightTop = randomPipeHeight();
      pipeHeightBottom = heightPage - pipeSpace - pipeHeightTop;
    }
    setState(() {});
    runPipeS();
  }

  Future fallBird() async {
    await Future.delayed(const Duration(milliseconds: 150));
    velocity = gravity;
    birdY += velocity;
    print('Fall - $birdY');
    if ((birdY + birdSize) > heightPage) {
      birdY = heightPage - birdSize;
      isEndGame = true;
      setState(() {});
      return;
    }
    setState(() {});
    fallBird();
  }

  Future flyBird() async {
    velocity = -45;
    birdY += velocity;
    if (birdY < 0) {
      birdY = 0;
    }
    setState(() {});
    print('Fly - $birdY');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Flappy bird"),
      // ),
      body: GestureDetector(
        onTap: () {
          if (isEndGame) return;
          flyBird();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: Colors.transparent,
                width: widthPage,
                height: heightPage,
              ),
              // Pipe trên
              Positioned(
                left: pipeX,
                top: 0,
                child: Container(
                  width: pipeWidth,
                  height: pipeHeightTop,
                  color: Colors.green,
                ),
              ),

              // Pipe dưới
              Positioned(
                left: pipeX,
                top: heightPage - pipeHeightBottom,
                child: Container(
                  width: pipeWidth,
                  height: pipeHeightBottom,
                  color: Colors.red,
                ),
              ),
              Positioned(
                top: birdY,
                left: birdX,
                child: Container(
                  width: birdSize,
                  color: Colors.green,
                  height: birdSize,
                ),
              ),
              Visibility(
                visible: !isStartGame,
                child: GestureDetector(
                  onTap: startGame,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(500),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isEndGame,
                child: GestureDetector(
                  onTap: startGame,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(500),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      child: Text(
                        "Replay",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double randomPipeHeight() {
    final random = Random();

    // Đặt giới hạn chiều cao pipe trên
    double minPipeHeight = 50;
    double maxPipeHeight = heightPage - pipeSpace - 100;

    return minPipeHeight +
        random.nextDouble() * (maxPipeHeight - minPipeHeight);
  }
}
