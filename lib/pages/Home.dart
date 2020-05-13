import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e2c35),
      body: Center(
        child: Container(

          child: Column(
            children:[
              Text('$count'),
              RaisedButton(child: Text(count.toString()
                ,style: TextStyle(
                  fontSize: 30,
                ),),
                onPressed: (){counter();},
                color: Colors.red,
                textColor: Colors.yellow,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,

              ),
            ]
          ),
        ),
      ),
    );
  }
  void counter(){
    setState(() {
      count++;
    });
  }
}
