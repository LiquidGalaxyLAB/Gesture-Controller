import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:gcmobile/widgets/camera.dart';
import 'package:gcmobile/screens/config.dart';
import 'package:gcmobile/services/classifier.dart';
import 'package:gcmobile/services/posenet.dart';


class PosenetScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PosenetScreen(this.cameras);

  @override
  _PosenetScreenState createState() => new _PosenetScreenState();
}

class _PosenetScreenState extends State<PosenetScreen>{
  Classifier classifier = new Classifier();
  Posenet posenet = new Posenet();
  var data;

  setRecognitions(recognitions) async{
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
    posenet.loadPosenetModel();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Camera(
            widget.cameras,
            setRecognitions,
          ),
          Positioned(
            top: 50,
            child: MaterialButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigScreen())),
              color: Color.fromRGBO(0, 0, 0, 0.6),
              textColor: Colors.white,
              child: Icon(Icons.settings, size: 17),
              padding: EdgeInsets.all(14),
              shape: CircleBorder(),
            ),
          )
        ],
      )
    );
  }
}
