// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';

import './textTranslation.dart';

import '../../constants.dart';

class TextToSignTranslation extends StatefulWidget {
  const TextToSignTranslation({
    Key? key,
  }) : super(key: key);

  @override
  State<TextToSignTranslation> createState() => _TextToSignTranslationState();
}

class _TextToSignTranslationState extends State<TextToSignTranslation> {
  final phraseController = TextEditingController();

  String _signString = 'Translate';

  void _renderTranslation(String signString) {
    // to lower case
    signString = signString.toLowerCase();
    var i = 0;
    // execute every 2 seconds
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => setState(
        () {
          if (i < signString.length) {
            _signString = signString[i];
            i++;
          } else {
            t.cancel();
            _signString = 'Translate';
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: kDefaultPadding * 1.75),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 36 + 20),
                    height: size.height * 0.9 - 27,
                    decoration: const BoxDecoration(
                      color: Color(0xff030a24),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
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
                      'assets/alphabet-sign-lan/icons8-sign-language-$_signString-500.png',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  _signString.toUpperCase(),
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: TextTranslation(_renderTranslation),
            )
          ],
        )
      ],
    );
  }
}