import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as imglib;

class Test{

  var shift = (0xFF << 24);
  Future<Image> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      var uvPixelStride = image.planes[1].bytesPerPixel;

      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width, height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for(int x=0; x < width; x++) {
        for(int y=0; y < height; y++) {
          final int uvIndex = uvPixelStride! * (x/2).floor() + uvRowStride*(y/2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = shift | (b << 16) | (g << 8) | r;
        }
      }

      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);
      // muteYUVProcessing = false;
      Uint8List bytes = Uint8List.fromList(png);
      return Image.memory(bytes);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return Image.asset("assets/handA.jpeg");
  }

}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:logger/logger.dart';
// import 'package:sign_language_dictionary_app/frames/home.dart';
// import 'package:sign_language_dictionary_app/frames/loading.dart';
// import 'classifier.dart';
// import 'dart:io';
// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
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
//   // var logger = Logger();
//   File? _image;
//   final picker = ImagePicker();
//   Image? _imageWidget;
//   // img.Image? fox;
//   Category? category;
//
//   @override
//   void initState() {
//     super.initState();
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
