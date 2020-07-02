import 'package:flutter/services.dart';
import 'package:gcmobile/utils/outputs.dart';
import 'package:gcmobile/services/sockets.dart';
import 'package:tflite/tflite.dart';

class Classifier{

  void loadModel() async{
    var res = await Tflite.loadModel(
      model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
    print(res);
  }

  List<dynamic> flattenInputs(inputs){
    List<double> flatten = [];
    try{
      List<dynamic> data = inputs[0]['keypoints'].values.toList();
      data = data.sublist(5,10);
      data.forEach((e) {
        flatten.add(e['x']*1000/1280);
        flatten.add(e['y']*1000/720);
      });
    } catch(exception){
      print(exception);
    }
    print(flatten);
    return flatten;
  }

  Future<int> classify(inputs) async{
    var platform = const MethodChannel('gcmobile');
    if(inputs.isNotEmpty)
      return await platform.invokeMethod('identifyPose', {"arg": inputs});
    return null;
  }

  handleResult(result){
    print(result);
    String color = colors[result];
    String string = strings[result];
    String event = sockets[result]['event'];
    String data = sockets[result]['data'];
    print(color + string);
    Socket.send(event, data);
  }

}
