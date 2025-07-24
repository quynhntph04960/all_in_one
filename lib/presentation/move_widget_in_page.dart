import 'package:flutter/material.dart';

class SignTextDraggablePage extends StatefulWidget {
  const SignTextDraggablePage({super.key});

  @override
  _SignTextDraggablePageState createState() => _SignTextDraggablePageState();
}

class _SignTextDraggablePageState extends State<SignTextDraggablePage> {
  Offset position = Offset(0, 0);
  final double boxSize = 100;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Di chuyển Widget trong page')),
        body: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy,
              child: GestureDetector(
                onPanStart: (details) {
                  print('⏱️ Bắt đầu chạm tại: ${details.globalPosition}');
                },
                onPanUpdate: (details) {
                  print(
                      '📍 details: ${details.delta.dx} - ${details.delta.dy}');
                  setState(() {
                    double newX = position.dx + details.delta.dx;
                    double newY = position.dy + details.delta.dy;

                    // Giới hạn trái, phải
                    newX = newX.clamp(0.0, screenSize.width - boxSize);
                    // Giới hạn trên, dưới
                    newY = newY.clamp(
                        0.0,
                        screenSize.height -
                            boxSize -
                            kToolbarHeight -
                            140); // trừ AppBar

                    position = Offset(newX, newY);
                  });
                  print('📍 Đang di chuyển đến: $position');
                },
                onPanEnd: (details) {
                  print('✅ Thả tay tại: $position');
                },
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    'signText',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
