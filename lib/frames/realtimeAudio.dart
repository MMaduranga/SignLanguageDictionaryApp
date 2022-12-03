import 'package:flutter/material.dart';
class RealTimeAudioTranslate extends StatefulWidget {
  const RealTimeAudioTranslate({Key? key}) : super(key: key);

  @override
  State<RealTimeAudioTranslate> createState() => _RealTimeAudioTranslateState();
}

class _RealTimeAudioTranslateState extends State<RealTimeAudioTranslate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
