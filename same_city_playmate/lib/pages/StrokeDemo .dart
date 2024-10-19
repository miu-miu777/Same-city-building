import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Swipe Detection')),
        body: SwipeDetectionWidget(),
      ),
    );
  }
}

class SwipeDetectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // 检测水平方向的划动
        if (details.delta.dx.abs() > details.delta.dy.abs()) {
          if (details.delta.dx > 0) {
            print("向右划动");
          } else {
            print("向左划动");
          }
        }
        // 检测垂直方向的划动
        else {
          if (details.delta.dy > 0) {
            print("向下划动");
          } else {
            print("向上划动");
          }
        }
      },
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text(
            'Swipe in any direction',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
