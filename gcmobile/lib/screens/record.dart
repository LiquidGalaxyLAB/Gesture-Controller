import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:gcmobile/widgets/camera.dart';
import 'package:gcmobile/widgets/recordModel.dart';
import 'package:gcmobile/services/sockets.dart';


class RecordScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  RecordScreen(this.cameras);

  @override
  _RecordScreenState createState() => new _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>{
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  String state = 'stopped';
  List<int> output = [1,0,0,0,0];

  record(List<int> output) async{
    print('\x1B[93mStarting in 5 seconds...');
    Timer(new Duration(seconds: 5), (){
      print('\x1B[92mCollecting...');
      state = 'collecting';
      Timer(new Duration(seconds: 30), (){
        print('\x1B[91mFinished...\x1B[97m');
        state = 'stopped';
        this.output = output;
        print(RecordModel.records);
      });
    });
  }

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
          RecordModel(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            _model,
            state,
            output
          ),
          Positioned(
            top: 50,
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    record([0,0,1,0,0]);
                  },
                  child: Text('Record'),
                ),
                RaisedButton(
                  onPressed: (){
                    var records = RecordModel.records;
                    Socket.send('record', '{"records": $records}');
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
