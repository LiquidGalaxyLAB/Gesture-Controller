import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:gcmobile/screens/posenet.dart';
import 'package:gcmobile/screens/socketio.dart';
import 'package:gcmobile/screens/config.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  HomeScreen(this.cameras);

  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text('PoseNet'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PosenetScreen(cameras))),
              ),
              RaisedButton(
                child: Text('Controller'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocketIoScreen())),
              ),
              RaisedButton(
                child: Text('Configs'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen())),
              ),
            ],
          ),
        )
    );
  }
}
