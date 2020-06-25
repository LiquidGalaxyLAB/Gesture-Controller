import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';

class Socket{
  static SocketIO socket;
  static String domain;

  static initialize(String address){
    domain = address;
    try{
      socket = SocketIOManager().createSocketIO(domain, "/");
      socket.init();
      socket.connect();
    } catch(e){
      print('Exception $e');
    }
  }

  static send(String event, String data){
    socket.sendMessage(event, data);
  }

  static close(){
    socket.disconnect();
  }
}
