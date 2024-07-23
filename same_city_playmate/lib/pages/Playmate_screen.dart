import 'package:flutter/material.dart';

class PlaymateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playmate Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Nearby Screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/Nearby');
          },
        ),
      ),
    );
  }
}