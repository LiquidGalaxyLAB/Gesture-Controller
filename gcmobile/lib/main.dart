import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gcmobile/utils/material_black.dart';
import 'screens/posenet.dart';
import 'screens/socketio.dart';
import 'screens/config.dart';
import 'package:gcmobile/services/sockets.dart';
import 'package:gcmobile/services/posenet.dart';
import 'package:gcmobile/services/voice.dart';

List<CameraDescription> cameras;

void main() async {
  Posenet posenet = new Posenet();
  VoiceCommands voice = new VoiceCommands();
  WidgetsFlutterBinding.ensureInitialized();
  try{
    cameras = await availableCameras();
    posenet.loadPosenetModel();
    await voice.initialize();
    // await Socket().initialize('192.168.0.190:8080');
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
        primarySwatch: primaryBlack,
      ),
      home: PosenetScreen(cameras),
    );
  }
}
