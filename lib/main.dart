import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_language_dictionary_app/frames/loading.dart';

List<CameraDescription>? camera;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  camera =await availableCameras();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const LoadingPage(),
      theme: ThemeData(
        primaryColor: Colors.yellowAccent,
        accentColor: const Color(0xff324dfa),
      ),
    ),
  );
}
