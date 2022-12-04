import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/controller/classifier.dart';

import 'home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Classifier? _classifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classifier=Classifier();
    delay();
  }
  void delay() async {
    await Future.delayed(const Duration(seconds: 3));
    delayLoading();
  }
  void delayLoading() {
    dispose();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  Home(classifier: _classifier,)));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
    );
  }
}
