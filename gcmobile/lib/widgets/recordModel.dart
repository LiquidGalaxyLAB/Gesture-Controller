import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordModel extends StatelessWidget {
  final List<dynamic> results;
  final String state;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  static List<dynamic> records = [];
  List<int> output = [];

  RecordModel(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
    this.model, this.state, this.output);



  modelData(){
    List<dynamic> flatten = [];
    try{
      List<dynamic> data = results[0]['keypoints'].values.toList();
      for(int i = 5; i < 10; i++){
        print(data[i]['part']);
        flatten.add(data[i]['x']);
        flatten.add(data[i]['y']);
      }
      flatten.add(output);
    } catch(a){
      print(a);
    }
    if(state=='collecting'){
      records.add(flatten);
    }
    print(flatten);
    return flatten;
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _renderKeypoints() {
      modelData();
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
            return Positioned(
              left: x - 6,
              top: y - 6,
              width: 100,
              height: 12,
              child: Container(
                child: Text(
                  "● ${k["part"]}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              ),
            );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: _renderKeypoints(),
    );
  }
}
