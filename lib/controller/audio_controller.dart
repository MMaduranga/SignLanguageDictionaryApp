import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioController extends GetxController {
  var isListening = false.obs;
  var speechText = "Speak......";
  SpeechToText speechToText=SpeechToText();

  void listen() async {
    if (!isListening.value) {
      bool available = await speechToText.initialize(
        onError: (val) {},
        onStatus: (val) {},
      );
      if (available) {
        isListening.value = true;
        speechToText.listen(onResult: (val) {
          speechText = val.recognizedWords;
        });
      }
    } else {
      isListening.value =false;
      speechToText.stop();
      speechText="";

    }
  }
}
