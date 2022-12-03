import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:sign_language_dictionary_app/frames/home.dart';
import 'controller/classifier.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Home(),
    theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        accentColor: Colors.lightBlueAccent),
  ));
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Classification',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Classifier _classifier;
//   var logger = Logger();
//
//   File? _image;
//   final picker = ImagePicker();
//   Image? _imageWidget;
//   img.Image? fox;
//   Category? category;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _classifier = Classifier();
//     getImage();
//   }
//
//
//
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       _image = File(pickedFile!.path);//
//       _imageWidget = Image.file(_image!);
//       print("000000000000000000000000000000000000");
//       print(_image);
//       _predict();
//     });
//   }
//
//   void _predict() async {
//     img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
//     var pred = _classifier.predict(imageInput);
//     print(pred);
//
//     setState(() {
//       this.category = pred;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TfLite Flutter Helper',
//             style: TextStyle(color: Colors.white)),
//       ),
//       body: Column(
//         children: <Widget>[
//           Center(
//             child: _image == null
//                 ? const Text('No image selected.')
//                 : Container(
//               constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height / 2),
//               decoration: BoxDecoration(
//                 border: Border.all(),
//               ),
//               child: _imageWidget,
//             ),
//           ),
//           const SizedBox(
//             height: 36,
//           ),
//           Text(
//             category != null ? category!.label : '',
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Text(
//             category != null
//                 ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
//                 : '',
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getImage,
//         tooltip: 'Pick Image',
//         child: const Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
