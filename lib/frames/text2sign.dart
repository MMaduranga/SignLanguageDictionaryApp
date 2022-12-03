import 'package:flutter/material.dart';
class TextToSignLanguage extends StatefulWidget {
  const TextToSignLanguage({Key? key}) : super(key: key);

  @override
  State<TextToSignLanguage> createState() => _TextToSignLanguageState();
}

class _TextToSignLanguageState extends State<TextToSignLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
