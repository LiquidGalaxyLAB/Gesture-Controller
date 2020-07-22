import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/posenet.dart';
import 'screens/home.dart';
import 'package:gcmobile/services/sockets.dart';
import 'package:gcmobile/services/posenet.dart';

List<CameraDescription> cameras;

void main() async {
  Posenet posenet = new Posenet();
  WidgetsFlutterBinding.ensureInitialized();
  try{
    cameras = await availableCameras();
    posenet.loadPosenetModel();
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
      home: HomeScreen(cameras),
    );
  }
}
