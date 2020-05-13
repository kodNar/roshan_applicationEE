import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e2c35),
      body: Center(
        child: RaisedButton(child: Text("Rosh dead"),
          onPressed: (){},
          color: Colors.red,
          textColor: Colors.yellow,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          splashColor: Colors.grey,

        ),
      ),
    );
  }
}
