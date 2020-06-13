import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class SocketIoScreen extends StatelessWidget {
  SocketIO socketIo;
  List<String> messages;

  @override
  void initState(){

  }

  Widget build(BuildContext context){
    print("Init");
    socketIo = SocketIOManager().createSocketIO("http://192.168.0.152:8080","/");
    socketIo.init();
    socketIo.connect();
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Move North'),
                    onPressed: () => socketIo.sendMessage("move", '{"direction":"N", "value":"1"}'),
                  ),
                  FlatButton(
                    child: Text('Move South'),
                    onPressed: () => socketIo.sendMessage("move", '{"direction":"S", "value":"1"}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Move West'),
                    onPressed: () => socketIo.sendMessage("move", '{"direction":"W", "value":"1"}'),
                  ),
                  FlatButton(
                    child: Text('Move East'),
                    onPressed: () => socketIo.sendMessage("move", '{"direction":"E", "value":"1"}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Rotate Left'),
                    onPressed: () => socketIo.sendMessage("rotate", '{"direction":"L", "value":"1"}'),
                  ),
                  FlatButton(
                    child: Text('Rotate Right'),
                    onPressed: () => socketIo.sendMessage("rotate", '{"direction":"R", "value":"1"}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Zoom In'),
                    onPressed: () => socketIo.sendMessage("zoom", '{"direction":"I", "value":"1"}'),
                  ),
                  FlatButton(
                    child: Text('Zoom out'),
                    onPressed: () => socketIo.sendMessage("zoom", '{"direction":"O", "value":"1"}'),
                  ),
                ],
              ),
              FlatButton(
                child: Text('Change Planet'),
                onPressed: () => socketIo.sendMessage("planet", '{}'),
              ),
              FlatButton(
                child: Text('Disconnect'),
                onPressed: () => socketIo.disconnect(),
              ),
            ],
          )
        )
      )
    );
  }
}
