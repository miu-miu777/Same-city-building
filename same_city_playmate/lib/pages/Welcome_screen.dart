import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Start'),
          onPressed: (){
            Navigator.pushNamed(context, '/Discovering');
          },
        ),
      ),
    );
  }
}