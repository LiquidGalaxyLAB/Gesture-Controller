import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:gcmobile/widgets/camera.dart';
import 'package:gcmobile/services/classifier.dart';


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

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    classifier.loadModel();
    return Scaffold(
      body: Camera(
        widget.cameras,
        setRecognitions,
      ),
    );
  }
}
