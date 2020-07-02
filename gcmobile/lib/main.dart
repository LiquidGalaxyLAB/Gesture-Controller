import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/home.dart';
import 'dart:async';
import 'package:gcmobile/services/sockets.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    cameras = await availableCameras();
    await Socket.initialize('192.168.0.152:8080');
  } on CameraException catch(e){
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

recordModel(){
  Timer(new Duration(seconds: 5), (){
    print('ROLA');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // recordModel();
    // print('\x1B[93mPINTO');
    return MaterialApp(
      title: 'Gesture Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(cameras),
    );
  }
}
