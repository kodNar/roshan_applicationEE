import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chance/chance.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final chance = Chance();
  int _counter = 0;
  bool roshDead = false;
  int phase = 1;
  Timer _timer;
  TimeOfDay now;
  TimeOfDay aegisExpireTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 5)));
  String checkText = "Click the image when Roshan has died";
  String text = "Aegis expires in:";
  String probabilityString = "";
  double probability = 0;

  void _startTimer() {
    checkText = "";
    _counter = 300; //300
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          if(phase == 3){
            if(probability >= 99){
              _showRoshSpawnDialog();
            }
            probability += 0.55555555555;
          }
        } else if (phase == 1) {
         calculateTime(phase);
         _playSound();
          text = 'Roshan can spawn in:';
          checkText = 'Aegis has expired';
          phase = 2;
          _counter = 180; //180;
        } else if (phase == 2) {
          _playSound();
          calculateTime(phase);
          text = 'Roshan has spawned in:';
          probabilityString = 'Roshan chance to have spawned: ';
          phase = 3;
          _counter = 180;//180;
        } else if(phase == 3){
          _playSound();
          phase = 4;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e2c35),
      body: Center(
        child: Container(
          child: Column(
            children: [
              roshReturn(),
            ],
          ),
        ),
      ),
    );
  }

  void calculateTime(int phase){
    if(phase == 1){
      aegisExpireTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 3)));
    }if(phase == 2){
      aegisExpireTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 3)));
    }
  }

  Widget roshReturn() {
    if (!roshDead) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:200),
            child: Text(checkText,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100,0,100,0),
            child: GestureDetector(
              onTap: () {
                _toggleRoshanDead();
                //do what you want here
              },
              child: CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.transparent,
                backgroundImage: ExactAssetImage('Assets/Images/RoshanPicture.png'),
              ),
            ),
          ),

        ],
      );
    } else {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top:50),
            child: Text(checkText,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ),
          phaseThree(),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.transparent,
                backgroundImage: ExactAssetImage('Assets/Images/Aegis.png'),
              ),
            ),
          ),
          Container(
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 45,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ),
          Text(
            '$_counter',
            style: TextStyle(
              fontSize: 55,
              fontFamily: 'Agency',
              color: Color(0xFF9e0c0c),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 100),
            child: Text('$aegisExpireTime',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ),

        ],
      );
    }
  }
  Widget phaseThree(){
    if(phase == 3){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(probabilityString,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            Text(
              probability.toStringAsPrecision(2),
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
            Text("%",
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Agency',
                color: Color(0xFF9e0c0c),
              ),
            ),
          ],
          ),
        ],
      );
    }return Text("");
  }
  void _playSound() async{
    AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
    switch(phase) {
      case 1: {
        assetsAudioPlayer.open(
          Audio("Assets/Sounds/AegisExpired.mp3"),
        );
      }
      break;
      case 2: {
        assetsAudioPlayer.open(
          Audio("Assets/Sounds/roshanCanSpawnnow.mp3"),
        );
      }
      break;
      case 3: {
        assetsAudioPlayer.open(
          Audio("Assets/Sounds/roshanHasSpawned.mp3"),
        );
      }
      break;
    }
  }

   void _showRoshSpawnDialog() {
     showDialog(
       context: context,
       builder: (BuildContext context) =>  CupertinoAlertDialog(
         title: Text('Roshan is up!'),
         content: Text('Click "ok" to get back'),
         actions: <Widget>[
           FlatButton(
             child: Text('OK'),
             onPressed: (){
               roshDead = false;
               Navigator.push(context,
                   MaterialPageRoute(builder: (context) => Home()));
             },
           ),
         ],
       )
     );
    }
  void _toggleRoshanDead() {
    setState(() {
      aegisExpireTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 2,minutes: 5)));
      roshDead = true;
      _startTimer();
    });
  }
}
