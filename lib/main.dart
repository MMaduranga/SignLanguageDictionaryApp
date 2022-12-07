import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/frames/loading.dart';

List<CameraDescription>? camera;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  camera =await availableCameras();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingPage(),
      theme: ThemeData(
        primaryColor: Colors.yellowAccent,
        accentColor: Color(0xff324dfa),
      ),
    ),
  );
}

