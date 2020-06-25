import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class Socket{
  static SocketIO socket;
  static String domain;
  static bool state = false;

  static initialize(String address) async{
    domain = address;
    socket = SocketIOManager().createSocketIO('http://' + domain, "/", socketStatusCallback: connectStatus);
    socket.init();
    socket.connect();
  }

  static send(String event, String data){
    socket.sendMessage(event, data);
  }

  static close() async{
    SocketIOManager().destroyAllSocket();
  }

  static connectStatus(status){
    print('Status => ' + status);
    switch(status.toString()){
      case 'connect_error':
        close();
        break;
      case 'connect':
        state = true;
        break;
    }
  }
}
