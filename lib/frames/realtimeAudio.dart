// ignore_for_file: file_names

import 'dart:async';

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
  String _signString = 'Audio Translate';
  String unavailableString = '';

  void _renderTranslation() {
    // to lower case
    String signString = audioController.speechText.toLowerCase();
    var i = 0;
    // execute every 2 seconds
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => setState(
        () {
          if (i < signString.length) {
            // check if signString is a english letter
            if (signString[i].codeUnitAt(0) > 96 &&
                    signString[i].codeUnitAt(0) < 123 ||
                signString[i].codeUnitAt(0) == 32) {
              _signString = signString[i];
            } else {
              unavailableString = signString[i];
              _signString = 'unavailable';
            }

            i++;
          } else {
            t.cancel();
            audioController.speechText = "Speak......";
            _signString = 'Audio Translate';
          }
        },
      ),
    );
  }

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
                      left: 20,
                      right: 20,
                      bottom: 36 + 20,
                    ),
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
                child: Visibility(
                  // if the signString is not empty, show the sign
                  visible: _signString == ' ' ? false : true,
                  child: Container(
                    margin: const EdgeInsets.all(50),
                    padding: const EdgeInsets.all(20),
                    height: 300,
                    width: 300,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        _signString == 'Audio Translate'
                            ? 'assets/icons/audio wave.gif'
                            : 'assets/alphabet-sign-lan/icons8-sign-language-$_signString-500.png',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: frameHeight * 0.12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _signString == 'unavailable' ? true : false,
                      child: Text(
                        '$unavailableString is unavailable',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _signString == 'unavailable' ? false : true,
                      child: Text(
                        _signString.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: frameHeight * 0.675,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  height: frameHeight * 0.07,
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
                  child: Text(audioController.speechText),
                ),
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (!audioController.isListening.value) {
                  setState(
                    () {
                      audioController.speechText = 'Listening...';
                    },
                  );
                  audioController.listen();
                } else {
                  audioController.notListen();
                  setState(() {});
                  Future.delayed(const Duration(seconds: 2));
                  setState(
                    () {
                      _renderTranslation();
                    },
                  );
                }
              },
              child: AvatarGlow(
                animate: audioController.isListening.value,
                endRadius: 70.0,
                showTwoGlows: true,
                glowColor: Colors.lightBlueAccent,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
