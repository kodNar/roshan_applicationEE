import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roshanapplication/Home.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e2c35),//theme color Gray
      body: Center(//Color(0xFF9e0c0c),Theme color red
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/Images/LoggaEE.png')
                ),
              ),
            ),
            Text(
              "Roshapp",
              style: TextStyle(
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c), //Theme color red
                fontSize: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
