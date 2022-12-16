import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioController extends GetxController {
  var isListening = false.obs;
  var speechText = "Speak......";
  SpeechToText speechToText = SpeechToText();

  void listen() async {
    isListening.value = true;
    bool available = await speechToText.initialize(
      onError: (val) {},
      onStatus: (val) {},
    );
    if (available) {
     await speechToText.listen(onResult: (val) {

        speechText = val.recognizedWords;
      });
    }
  }

  void notListen() async {
    isListening.value =false;
    await speechToText.stop();
  }

}
