// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {
  static IO.Socket socket;

  // static SocketIO socket;
  static String domain;
  static Function optionsCallback;
  static int state = 0;

  initialize(String address, Function callback) async {
    domain = address;
    optionsCallback = callback;
    // socket = SocketIOManager().createSocketIO('http://' + domain, "/", socketStatusCallback: _connectStatus);
    // socket.init();
    // socket.connect();
    socket = IO.io('http://$domain', IO.OptionBuilder().disableAutoConnect().setTransports(['websocket']).build());
    socket.connect();
    socket.onConnect((data) {
      state = 1;
      print('state: $state | Connected');
      optionsCallback();
    });
    socket.onDisconnect((data) {
      state = 0;
      print('error: ${data.toString()}');
      print('state: $state | Disconnected');
      optionsCallback();
    });
    socket.onConnectError((data) {
      state = -1;
      print('state: $state | Connection Error');
      optionsCallback();
    });
  }

  send(String event, String data) {
    // socket.sendMessage(event, data);
    socket.emit(event, data);
  }

  close() async {
    // socket.disconnect();
    socket.disconnect();
  }

  // _connectStatus(dynamic status) {
  //   print(status);
  //   switch (status.toString()) {
  //     case 'connect_error':
  //       close();
  //       state = -1;
  //       break;
  //     case 'disconnect':
  //       state = 0;
  //       break;
  //     case 'connect':
  //       state = 1;
  //       break;
  //   }
  //   optionsCallback();
  // }
}
