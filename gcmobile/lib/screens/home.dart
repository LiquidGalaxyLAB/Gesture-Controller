import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gcmobile/screens/config.dart';
import 'package:gcmobile/screens/posenet.dart';
import 'package:gcmobile/screens/socketio.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  HomeScreen(this.cameras);

  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('PoseNet'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PosenetScreen(cameras))),
                ),
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('Controller'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SocketIoScreen())),
                ),
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  child: Text('Configs'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen())),
                ),
              ),
            ],
          ),
        )
    );
  }
}
