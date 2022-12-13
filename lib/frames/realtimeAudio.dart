import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/constants.dart';
import 'package:sign_language_dictionary_app/controller/audio_controller.dart';

class RealTimeAudioTranslate extends StatefulWidget {
  const RealTimeAudioTranslate({Key? key}) : super(key: key);

  @override
  State<RealTimeAudioTranslate> createState() => _RealTimeAudioTranslateState();
}

class _RealTimeAudioTranslateState extends State<RealTimeAudioTranslate> {
  AudioController audioController = AudioController();
  @override
  Widget build(BuildContext context) {
    double frameHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 36 + 20),
                    height: frameHeight * 0.75,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: frameHeight * 0.05,
                  )
                ],
              ),
              Positioned(
                top: frameHeight * 0.2,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(50),
                  padding: const EdgeInsets.all(20),
                  height: 300,
                  width: 300,
                  child: const FittedBox(
                    fit: BoxFit.fill,
                    child: Text("hi"),
                  ),
                ),
              ),
              Positioned(
                top: frameHeight * 0.675,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: frameHeight * 0.075,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: primaryTeal.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child:  Text(audioController.speechText),
                ),
              ),
            ],
          ),
          Center(
              child: GestureDetector(
                onTap: (){
                  audioController.listen();
                },
                  child: AvatarGlow(
            animate: audioController.isListening.value,
            endRadius: 70.0,
            showTwoGlows: true,
            glowColor: Colors.blue.shade900,
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: primaryTeal.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Icon(
                  audioController.isListening.value
                      ? Icons.mic
                      : Icons.mic_none,
                  color: Colors.white,
                )),
          ))),
        ],
      ),
    );
  }
}
