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

  // List<Widget> _renderKeypoints() {
  //     var lists = <Widget>[];
  //     results.forEach((re) {
  //       var list = re["keypoints"].values.map<Widget>((k) {
  //         var _x = k["x"];
  //         var _y = k["y"];
  //         var scaleW, scaleH, x, y;
  //
  //         if (screenH / screenW > previewH / previewW) {
  //           scaleW = screenH / previewH * previewW;
  //           scaleH = screenH;
  //           var difW = (scaleW - screenW) / scaleW;
  //           x = (_x - difW / 2) * scaleW;
  //           y = _y * scaleH;
  //         } else {
  //           scaleH = screenW / previewW * previewH;
  //           scaleW = screenW;
  //           var difH = (scaleH - screenH) / scaleH;
  //           x = _x * scaleW;
  //           y = (_y - difH / 2) * scaleH;
  //         }
  //           return Positioned(
  //             left: x - 6,
  //             top: y - 6,
  //             width: 100,
  //             height: 12,
  //             child: Container(
  //               child: Text(
  //                 "● ${k["part"]}",
  //                 style: TextStyle(
  //                   color: Color.fromRGBO(37, 213, 253, 1.0),
  //                   fontSize: 12.0,
  //                 ),
  //               ),
  //             ),
  //           );
  //       }).toList();
  //
  //       lists..addAll(list);
  //     });
  //
  //     return lists;
  //   }
}
