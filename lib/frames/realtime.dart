import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sign_language_dictionary_app/controller/drawer.dart';

class RealTimeTranslate extends StatefulWidget {
  const RealTimeTranslate({Key? key}) : super(key: key);

  @override
  State<RealTimeTranslate> createState() => _RealTimeTranslateState();
}

class _RealTimeTranslateState extends State<RealTimeTranslate> {
  File? image;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.90,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20 * 1.75),
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
            child: Container(
              margin: const EdgeInsets.all(50),
              padding: const EdgeInsets.all(20),
              height: 300,
              width: 300,
              child: const FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  'Text',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: pickImageC),

    );
  }
}
