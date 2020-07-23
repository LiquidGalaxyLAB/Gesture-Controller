import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:gcmobile/utils/voice/commands.dart';
import 'package:gcmobile/utils/outputs.dart';
import 'package:gcmobile/services/sockets.dart';

class VoiceCommands{
  static SpeechToText controller = SpeechToText();

  initialize(){
    return controller.initialize(onStatus: _onStatus);
  }

  listen(){
    if(controller.isListening)
     return null;
    else
      controller.listen(onResult: _onResult, listenFor: Duration(seconds: 5));
  }

  stop(){
    return controller.stop();
  }

  status(){
    print(controller.lastStatus);
    return controller.lastStatus;
  }

  _onResult(SpeechRecognitionResult result){
    String str = result.recognizedWords.toLowerCase();
    int cIndex;
    String socketData;
    var cOption, command, cValue, socketEvent;
    if(result.finalResult){
      print(result.recognizedWords);
      command = findCommands(str);
      cIndex = command['index'];
      cValue = command['value'];
      if(!cIndex.isNaN){
        command = commands[cIndex]['value'];
        str = str.split(cValue)[1].replaceFirst(' ', '');
        if(command < 9){
          cOption = findOptions(str, cIndex);
          command = command + cOption;
        }
        socketEvent = sockets[command]['event'];
        socketData = sockets[command]['data'];
        socketData = socketData.replaceFirst('%location', str);
        print(socketData);
        print(terminalColor[command] + strings[command] + '\x1B[97m');
        Socket.send(socketEvent, socketData);
      }
    }
  }

  _onStatus(String status){
    // print(status);
  }

  findCommands(String str){
    for(int i = 0; i < commands.length; i++){
      var c = commands[i];
      for(String v in c['variations'])
        if(str.contains(v))
          return {
            'index': i,
            'value': v
          };
    }
    return null;
  }

  findOptions(String str, int index){
    var command = commands[index];
    if(index == 4)
      return str;
    for(int i = 0; i < command['options'].length; i++){
      var option = command['options'][i];
      check(var value) => str.contains(value);
      if(option.any(check))
        return i;
    }
  }

  convertCommand(String str){
    str = str.toUpperCase();
    print(str);
    strings.forEach((index, value) {
      if(value == str)
        return index;
      return null;
    });
  }

}
