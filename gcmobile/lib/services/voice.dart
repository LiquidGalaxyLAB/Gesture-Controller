import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:gcmobile/utils/voice/commands.dart';

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
    String _str = result.recognizedWords.toLowerCase();
    String _sub = '';
    if(result.finalResult){
      int commandIndex = checkCommands(_str);
      print(result.recognizedWords);
      if(!commandIndex.isNaN){
        print('\x1B[33mCOMMAND ' + commands[commandIndex]['value'] + '\x1B[97m');
        _sub = _str.split(commands[commandIndex]['value'])[1];
        String commandOption = checkOptions(_sub, commandIndex);
        print(commandOption);
      }
    }
  }

  _onStatus(String status){
    // print(status);
  }

  checkCommands(String str){
    for(int i = 0; i < commands.length; i++){
      var c = commands[i];
      for(String v in c['variations'])
        if(str.contains(v))
          return i;
    }
    return null;
  }

  checkOptions(String str, int index){
    var command = commands[index];
    for(int i = 0; i < command['options'].length; i++){
      var option = command['options'][i];
      check(var value) => str.contains(value);
      if(option.any(check))
        return option[0];
    }
  }

}
