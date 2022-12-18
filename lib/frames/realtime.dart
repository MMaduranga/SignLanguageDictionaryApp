// ignore_for_file: avoid_print, no_logic_in_create_state, depend_on_referenced_packages

import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:sign_language_dictionary_app/constants.dart';
import 'dart:io';

import '../controller/classifier.dart';
import '../main.dart';

class RealTimeTranslate extends StatefulWidget {
  final Classifier? title;
  const RealTimeTranslate({Key? key, this.title}) : super(key: key);

  @override
  State<RealTimeTranslate> createState() =>
      _RealTimeTranslateState(classifier: title);
}

class _RealTimeTranslateState extends State<RealTimeTranslate> {
  CameraController? cameraController;
  File? image;
  late File _image;
  String? label;
  String? score;
  Classifier? classifier;
  bool grid = false;
  bool camStatus = false;
  int imageCount = 0;
  Color frameColor = primaryColor;

  _RealTimeTranslateState({this.classifier});

  @override
  void initState() {
    // ignore: todo
    super.initState();
  }

  Future predict(var pickedFile) async {
    _image = File(pickedFile!.path);
    img.Image imageInput = img.decodeImage(_image.readAsBytesSync())!;
    var pred = classifier!.predict(imageInput);
    score = pred.score.toStringAsFixed(3);
    label = pred.label;
    print("********************************************");
    print(label);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadCamera() async {
    cameraController = CameraController(camera![0], ResolutionPreset.medium);
    cameraController!.initialize().then(
      (value) {
        if (!mounted) {
          return;
        } else {
          setState(
            () {
              cameraController!.startImageStream(
                (imageStream) {
                  grid = true;
                  imageCount++;
                  print(imageCount);
                  if (imageCount % 30 == 0) {
                    handlePredict(imageStream);
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  void handlePredict(imageStream) async {
    img.Image imageModel = img.Image.fromBytes(
        imageStream.width, imageStream.height, imageStream.planes[0].bytes,
        format: img.Format.bgra);
    await predict(img.encodeJpg(imageModel));
  }

  // Future pickImageC() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //
  //     if (image == null) return;
  //
  //     final imageTemp = File(image.path);
  //
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

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
                height: size.height * 0.89,
                width: size.width,
                child: !grid
                    ? Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 36 + 20,
                        ),
                        decoration: BoxDecoration(
                          color: frameColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      )
                    : CameraPreview(cameraController!),
              ),
            ],
          ),
          Positioned(
            top: size.height * 0.75,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: label == null
                  ? const Text(
                      "VIDEO TRANSLATE ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    )
                  : Text(
                      label.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
            ),
          ),
          Positioned(
            top: size.height * 0.3,
            left: 0,
            right: 0,
            child: Visibility(
              visible: !camStatus,
              child: Image.asset(
                'assets/images/camera animation.gif',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.85,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (!camStatus) {
                  camStatus = true;
                  loadCamera();
                } else {
                  cameraController!.dispose();
                  setState(
                    () {
                      grid = false;
                      camStatus = false;
                      imageCount = 0;
                    },
                  );
                }
              },
              child: AvatarGlow(
                animate: camStatus,
                endRadius: 70.0,
                showTwoGlows: true,
                glowColor: Colors.lightBlueAccent,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: frameColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: primaryTeal.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Icon(
                    camStatus
                        ? Icons.add_a_photo_sharp
                        : Icons.add_a_photo_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
