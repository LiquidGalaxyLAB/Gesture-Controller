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
              FlatButton(
                child: Text('Send event test'),
                onPressed: () => socketIo.sendMessage("event", '{"message":"blablabla"}'),
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
