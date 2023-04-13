import "package:speech_to_text/speech_to_text.dart";
import 'dart:async';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnable = false;

  void intiSpeech() async {
    _speechEnable = await _speechToText.initialize();
  }

  Future<String> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (result) {
        if(result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
    );
    return completer.future;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnable;
}
