import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'package:gcmobile/widgets/camera.dart';
import 'package:gcmobile/widgets/bndbox.dart';


class PosenetScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PosenetScreen(this.cameras);

  @override
  _PosenetScreenState createState() => new _PosenetScreenState();
}

class _PosenetScreenState extends State<PosenetScreen>{
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }
  loadModel() async{
    var res = await Tflite.loadModel(
      model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
    print(res);
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    loadModel();
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            setRecognitions,
          ),
          BndBox(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            _model),
        ],
      )
    );
  }
}
