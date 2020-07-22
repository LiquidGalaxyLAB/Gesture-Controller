import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gcmobile/screens/config.dart';
import 'package:gcmobile/screens/posenet.dart';
import 'package:gcmobile/screens/socketio.dart';
import 'package:gcmobile/services/voice.dart';

class HomeScreen extends StatelessWidget {

  final List<CameraDescription> cameras;
  HomeScreen(this.cameras);

  VoiceCommands voice = new VoiceCommands();

  voiceInit() async{
    await voice.initialize();
    voice.listen();
    Timer.periodic(Duration(seconds: 2), (timer) {
      voice.listen();
    });
  }

  Widget build(BuildContext context){
    voiceInit();
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('Start'),
                  onPressed: () => voice.listen(),
                ),
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('Stop'),
                  onPressed: () => voice.stop(),
                ),
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('Status'),
                  onPressed: () => voice.status(),
                ),
              ),
              // Container(
              //   width: 200,
              //   child: RaisedButton(
              //     child: Text('PoseNet'),
              //     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PosenetScreen(cameras))),
              //   ),
              // ),
              // Container(
              //   width: 200,
              //   child: RaisedButton(
              //     child: Text('Controller'),
              //     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocketIoScreen())),
              //   ),
              // ),
              // Container(
              //   width: 200,
              //   child: RaisedButton(
              //     child: Text('Configs'),
              //     onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen())),
              //   ),
              // ),
            ],
          ),
        )
    );
  }
}
