import 'package:flutter/material.dart';

class DiscoveringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discovering Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed:(){
                  Navigator.pushNamed(context, '/Playmate');
                },
                child: Text('Go to Second Screen'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Nearby');
                },
                child:  Text('Go to Nearby Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
