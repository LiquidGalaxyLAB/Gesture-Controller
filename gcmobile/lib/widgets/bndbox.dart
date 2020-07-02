import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:gcmobile/services/sockets.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
    this.model);

    recordModel(){
      Timer(new Duration(seconds: 5), (){
        print('ROLA');
      });
    }

  modelData(){
    var min = [354.5618838780572, 212.92657387419285, 276.52705231605216, 208.28318099529423, 378.6086404067963, 156.4679680837293, 220.86749026649875, 146.0281627870675, 346.974995336105, 52.84580877649853];
    var max = [439.0200459701508, 261.8135900664748, 345.08968598661363, 260.334872567398, 512.6335801390411, 343.64877325284783, 324.73249885306257, 352.0085301687378, 576.9220172963876, 423.9240450794004];
    List<double> flatten = [];
    try{
      List<dynamic> data = results[0]['keypoints'].values.toList();
      for(int i = 5; i < 10; i++){
        flatten.add(data[i]['x']);
        flatten.add(data[i]['y']);
      }
      print(flatten);
      for(int i=0;i<10;i++){
        if((i%2)==0)
          flatten[i]=(flatten[i]*1000/1280);
        else
          flatten[i]=(flatten[i]*1000/720);
      }
      // data.forEach((part) {
      //   flatten.add(part['x']);
      //   flatten.add(part['y']);
      // });
      // print(flatten);
    } catch(a){
      print(a);
    }
    print(flatten);
    return flatten;
  }

  identify() async {
    List<dynamic> flattenData = modelData();
    var platform = const MethodChannel('gcmobile');
    if(flattenData.isNotEmpty)
    try {
      var result = await platform.invokeMethod('identifyPose', {"arg": flattenData});
      switch(result){
        case 0:
          print('\x1B[90mIDLE');
          // Socket.send(event, data)
          break;
        case 1:
          print('\x1B[94mNORTH');
          Socket.send("move", '{"direction":"N", "value":"1"}');
          break;
        case 2:
          print('\x1B[93mSOUTH');
          Socket.send("move", '{"direction":"S", "value":"1"}');
          break;
        case 3:
          print('\x1B[95mWEST');
          Socket.send("move", '{"direction":"W", "value":"1"}');
          break;
        case 4:
          print('\x1B[96mEAST');
          Socket.send("move", '{"direction":"E", "value":"1"}');
          break;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    identify();
    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      // results.forEach((re) {
      //   var list = re["keypoints"].values.map<Widget>((k) {
      //     var _x = k["x"];
      //     var _y = k["y"];
      //     var scaleW, scaleH, x, y;
      //
      //     if (screenH / screenW > previewH / previewW) {
      //       scaleW = screenH / previewH * previewW;
      //       scaleH = screenH;
      //       var difW = (scaleW - screenW) / scaleW;
      //       x = (_x - difW / 2) * scaleW;
      //       y = _y * scaleH;
      //     } else {
      //       scaleH = screenW / previewW * previewH;
      //       scaleW = screenW;
      //       var difH = (scaleH - screenH) / scaleH;
      //       x = _x * scaleW;
      //       y = (_y - difH / 2) * scaleH;
      //     }
      //       return Positioned(
      //         left: x - 6,
      //         top: y - 6,
      //         width: 100,
      //         height: 12,
      //         child: Container(
      //           child: Text(
      //             "● ${k["part"]}",
      //             style: TextStyle(
      //               color: Colors.red,
      //               fontSize: 12.0,
      //             ),
      //           ),
      //         ),
      //       );
      //   }).toList();
      //
      //   lists..addAll(list);
      // });

      return lists;
    }

    return Stack(
      children: _renderKeypoints(),
    );
  }
}
