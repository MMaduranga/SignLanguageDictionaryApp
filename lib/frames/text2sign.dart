import 'package:flutter/material.dart';

import 'textToSignTranslation/textToSignTranslation.dart';


class TextToSignLanguage extends StatefulWidget {
  const TextToSignLanguage({Key? key}) : super(key: key);

  @override
  State<TextToSignLanguage> createState() => _TextToSignLanguageState();
}

class _TextToSignLanguageState extends State<TextToSignLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const TextToSignTranslation(),
          ],
        ),
      ),
    );
  }
}
