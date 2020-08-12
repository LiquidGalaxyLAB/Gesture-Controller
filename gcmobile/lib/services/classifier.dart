import 'package:flutter/services.dart';
import 'package:gcmobile/utils/outputs.dart';
import 'package:gcmobile/services/sockets.dart';

class Classifier{

  List<double> min = [0.5116613510756465, 0.37486665058321883, 0.37261776326924967, 0.3681950739562473, 0.5494283969871714, 0.2580333533730113, 0.3153298175358168, 0.24229021177731833, 0.5104081059059901, 0.06286643401921141, 0.2098146888480084, 0.05631470757695742];
  List<double> max = [0.6578512345141136, 0.6754291781053053, 0.5322033387643319, 0.679390533625731, 0.7279412258438199, 0.8195980721437132, 0.5071305076048852, 0.8287952102725579, 0.8165780178055195, 0.9698613447520236, 0.547634732653523, 0.984388456784571];

  List<dynamic> normalize(data){
    List<double> normalized = [];
    print(data);
    for(int i = 0; i < data.length; i++){
      normalized.add((data[i]-min[i])/max[i]-min[i]);
    }
    return normalized;
  }

  List<dynamic> flattenInputs(inputs){
    List<double> flatten = [];
    try{
      List<dynamic> rawData = inputs[0]['keypoints'].values.toList();
      rawData = rawData.sublist(5,11);
      for(var value in rawData){
        flatten.add(value['x']);
        flatten.add(value['y']);
      }
      // flatten = normalize(flatten);
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

  void handleResult(result){
    String color = terminalColor[result];
    String string = strings[result];
    String event = sockets[result]['event'];
    String data = sockets[result]['data'];
    print(color + string);
    Socket().send(event, data);
  }

}
