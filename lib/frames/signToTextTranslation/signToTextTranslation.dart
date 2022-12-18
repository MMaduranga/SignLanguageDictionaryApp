// ignore_for_file: file_names, depend_on_referenced_packages, no_logic_in_create_state, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_language_dictionary_app/controller/classifier.dart';
import 'package:image/image.dart' as img;

import '../../constants.dart';

class SignToTextTranslation extends StatefulWidget {
  final Classifier? title;
  const SignToTextTranslation({Key? key, this.title}) : super(key: key);

  @override
  State<SignToTextTranslation> createState() =>
      _SignToTextTranslationState(classifier: title);
}

class _SignToTextTranslationState extends State<SignToTextTranslation> {
  File? image;
  Classifier? classifier;
  _SignToTextTranslationState({this.classifier});
  late File _image;
  String label = "Select a image...";
  String score = "";

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      predict(image);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
                    height: frameHeight * 0.85,
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
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(
                    top: AppBar().preferredSize.height * 0.7,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  height: frameHeight * 0.75,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: image != null
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            child: Image.file(image!),
                          )
                        : imageContainer(
                            context,
                            const AssetImage(
                              'assets/images/gallery_animation.gif',
                            ),
                          ),
                  ),
                ),
              ),
              Positioned(
                top: frameHeight * 0.7,
                left: 0,
                right: 0,
                child: const Center(
                  child: Text(
                    'IMAGE TRANSLATE',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: frameHeight * 0.775,
                left: 0,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: label == "Select a image..."
                      ? const EdgeInsets.all(20)
                      : const EdgeInsets.symmetric(horizontal: 20),
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
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage();
        },
        child: const Icon(Icons.image_search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget imageContainer(BuildContext context, ImageProvider img) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(image: img, fit: BoxFit.fill),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }

  Future predict(final pickedFile) async {
    _image = File(pickedFile!.path);
    img.Image imageInput = img.decodeImage(_image.readAsBytesSync())!;
    var pred = classifier!.predict(imageInput);
    score = pred.score.toStringAsFixed(3);
    label = pred.label.split(' ')[1];
  }
}
