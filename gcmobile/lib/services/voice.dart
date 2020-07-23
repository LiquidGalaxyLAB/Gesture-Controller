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
    int cIndex, cValue, command;
    var cOption;
    if(result.finalResult){
      print(result.recognizedWords);
      cIndex = findCommands(str);
      if(!cIndex.isNaN){
        cValue = commands[cIndex]['value'];
        // print(commands[cIndex]['variations'][0]);
        str = str.split(commands[cIndex]['variations'][0])[1];
        cOption = findOptions(str, cIndex);
        command = cOption ??
        print(cOption);
        print(cValue + cOption);
        // var finalCommand = commands[commandIndex]['value'] + commandOption;
        // finalCommand = convertCommand(finalCommand);
        // print(finalCommand);
        // finalCommand = sockets[finalCommand];
        // Socket.send(sockets['event'], sockets['data']);
      }
    }
    print('\x1B[33mCOMMAND ' + commands[cIndex]['value'] + '\x1B[97m');
  }

  _onStatus(String status){
    // print(status);
  }

  findCommands(String str){
    for(int i = 0; i < commands.length; i++){
      var c = commands[i];
      for(String v in c['variations'])
        if(str.contains(v))
          return i;
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
