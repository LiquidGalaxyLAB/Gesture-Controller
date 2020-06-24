import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
    this.model);

  modelData(){
    List<double> flatten = [];
    try{
      List<dynamic> data = results[0]['keypoints'].values.toList();
      data.forEach((part) {
        flatten.add(part['x']);
        flatten.add(part['y']);
      });
    } catch(a){
      print(a);
    }
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
          break;
        case 1:
          print('\x1B[94mNORTH');
          break;
        case 2:
          print('\x1B[93mSOUTH');
          break;
        case 3:
          print('\x1B[95mWEST');
          break;
        case 4:
          print('\x1B[96mEAST');
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
