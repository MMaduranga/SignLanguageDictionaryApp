import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'image2text.dart';
import 'realtime.dart';
import 'realtimeAudio.dart';
import 'text2sign.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> borderList = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHight = size.height + AppBar().preferredSize.height;
    double containerWidth = size.width * 0.8;
    Color containerColor = Colors.lightBlueAccent;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top,
                  width: containerWidth,
                  color: containerColor,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: containerHight * 0.4,
                  width: containerWidth,
                  decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Hello,",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "What can i\ntranslate for\nyou today?",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: containerHight * 0.07,
                  width: containerWidth,
                  color: containerColor,
                  child: Container(
                    height: containerHight * 0.075,
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                        )),
                  ),
                ),
              ],
            ),
            Container(
              width: size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              borderList[0] = true;
                              borderList[1] =
                              borderList[2] = borderList[3] = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RealTimeTranslate()));
                          },
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: boxDecoration(containerColor, 0),
                            child: buttonContent(
                                FontAwesomeIcons.camera, "Video Translate"),
                          )),
                      const SizedBox(width: 30),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              borderList[1] = true;
                              borderList[0] =
                              borderList[2] = borderList[3] = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RealTimeAudioTranslate()));
                          },
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: boxDecoration(containerColor, 1),
                            child: buttonContent(
                                FontAwesomeIcons.microphone, "Audio Translate"),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              borderList[2] = true;
                              borderList[0] =
                              borderList[1] = borderList[3] = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImageToText()));
                          },
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: boxDecoration(containerColor, 2),
                            child: buttonContent(
                                FontAwesomeIcons.image, "Image translate"),
                          )),
                      const SizedBox(width: 30),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              borderList[3] = true;
                              borderList[0] =
                              borderList[1] = borderList[2] = false;
                            });
                            //sleep(Duration(milliseconds: 1000));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TextToSignLanguage()));
                          },
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: boxDecoration(containerColor, 3),
                            child: buttonContent(FontAwesomeIcons.solidKeyboard,
                                "Text Translate"),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration boxDecoration(Color color, int index) {
    return BoxDecoration(
        color: Colors.white,
        border: borderList[index]
            ? Border.all(color: color, width: 3.0)
            : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 2), blurRadius: 10, color: Colors.grey),
          BoxShadow(
              offset: Offset(-5, -5), blurRadius: 15, color: Colors.white)
        ]);
  }

  Widget buttonContent(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 60,
        ),
       const SizedBox(
          height: 10,
        ),
        Text(text),
      ],
    );
  }
}
