import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_language_dictionary_app/controller/classifier.dart';
import 'package:image/image.dart' as img;

class SignToTextTranslation extends StatefulWidget {
  final Classifier? title;
  SignToTextTranslation({Key? key, this.title}) : super(key: key);

  @override
  State<SignToTextTranslation> createState() =>
      _SignToTextTranslationState(classifier: title);
}

class _SignToTextTranslationState extends State<SignToTextTranslation> {
  File? image;
  Classifier? classifier;
  _SignToTextTranslationState({this.classifier});
  late File _image;
   String? label;
   String? score;

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
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent),
                    ),
                    child: Image.file(image!))
                : imageContainer(
                    context,
                    const AssetImage(
                        'assets/images/icons8-sign-to-text-image-512.png')),

            Container(
              height: MediaQuery.of(context).size.height*0.15,
              width:  MediaQuery.of(context).size.width*0.7,
              decoration:BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(offset: Offset(0, 2), blurRadius: 10, color: Colors.grey),
                    BoxShadow(offset: Offset(-5, -5), blurRadius: 15, color: Colors.white)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label != null ? label!.split(' ')[1] : "Select An Image",style:const TextStyle(fontSize: 30),),
                Text(label != null ? score! : ""),
              ],
            ),),
            FloatingActionButton(
                onPressed: () {
                  pickImage();
                },
                child: const Icon(Icons.pages_outlined)),
          ],
        ),
      ),
    ));
  }

  Widget imageContainer(BuildContext context, ImageProvider img) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration:
          BoxDecoration(image: DecorationImage(image: img, fit: BoxFit.fill)),
    );
  }

  Future predict(final pickedFile) async {
    _image = File(pickedFile!.path);
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = classifier!.predict(imageInput);
    score = pred.score.toStringAsFixed(3);
    label = pred.label;
  }
}
