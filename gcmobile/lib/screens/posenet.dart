import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

import 'package:gcmobile/widgets/camera.dart';
import 'package:gcmobile/services/classifier.dart';
// import 'package:gcmobile/widgets/bndbox.dart';


class PosenetScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PosenetScreen(this.cameras);

  @override
  _PosenetScreenState createState() => new _PosenetScreenState();
}

class _PosenetScreenState extends State<PosenetScreen>{
  Classifier classifier = new Classifier();
  var data;

  setRecognitions(recognitions, imageHeight, imageWidth) async{
    if(recognitions.isNotEmpty){
      data = classifier.flattenInputs(recognitions);
      data = await classifier.classify(data);
      classifier.handleResult(data);
    }
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
    loadModel();
    return Scaffold(
      body: Camera(
        widget.cameras,
        setRecognitions,
      ),
    );
  }
}
