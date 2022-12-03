// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SignToTextTranslation extends StatefulWidget {
  const SignToTextTranslation({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<SignToTextTranslation> createState() => _SignToTextTranslationState();
}

class _SignToTextTranslationState extends State<SignToTextTranslation> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign to Text Translation"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              image != null
                  ? Image.file(image!)
                  : Container(
                      height: 512,
                      // color: Colors.deepPurple[400],
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/images/icons8-sign-to-text-image-512.png',
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: const Color(0xff324dfa),
                  child: const Text(
                    "Pick Image from Gallery",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    pickImage();
                  }),
            ],
          ),
        ));
  }
}
