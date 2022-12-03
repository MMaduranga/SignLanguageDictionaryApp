import 'package:flutter/material.dart';

import '../frames/signToTextTranslation/signToTextTranslation.dart';

class ImageToText extends StatefulWidget {
  const ImageToText({Key? key}) : super(key: key);

  @override
  State<ImageToText> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const SignToTextTranslation(
          title: 'Hello',
        ),
      ),
    );
  }
}
