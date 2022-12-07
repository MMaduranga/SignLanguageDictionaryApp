import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sign_language_dictionary_app/controller/drawer.dart';
import 'package:sign_language_dictionary_app/controller/test.dart';

import '../controller/classifier.dart';
import '../main.dart';
import 'package:image/image.dart' as img;

class RealTimeTranslate extends StatefulWidget {
  final Classifier? title;
  RealTimeTranslate({Key? key, this.title}) : super(key: key);

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
  bool camStatus=false;

  _RealTimeTranslateState({this.classifier});


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
  }

  Future predict(var pickedFile) async {
    pickedFile =Test().convertYUV420toImageColor(pickedFile);
    _image = File(pickedFile!.path);
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = classifier!.predict(imageInput);
    score = pred.score.toStringAsFixed(3);
    label = pred.label;
    print("********************************************");
    print(label);

  }
@override
  void dispose(){
    super.dispose();
  cameraController!.dispose();

}
  void loadCamera() {
    cameraController = CameraController(camera![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            grid = true;
            //predict(imageStream);

          });
        });
      }
    });
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
                child: !grid
                    ? Container(
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
                      )
                    :CameraPreview(cameraController!),
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
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  label == null ? "Hi" : label.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(!camStatus){
          camStatus=true;
          loadCamera();
        } else{
          setState(() {
            grid=false;
            camStatus=false;
          });
        }

      }),
    );
  }
}
