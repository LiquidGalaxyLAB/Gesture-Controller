import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/home.dart';
import 'screens/posenet.dart';
import 'package:gcmobile/services/sockets.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    cameras = await availableCameras();
    // await Socket.initialize('192.168.0.152:8080');
  } on CameraException catch(e){
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PosenetScreen(cameras),
    );
  }
}
