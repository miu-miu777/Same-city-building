import 'package:flutter/material.dart';

class NearbyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Home Screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/Discovering');
          },
        ),
      ),
    );
  }
}