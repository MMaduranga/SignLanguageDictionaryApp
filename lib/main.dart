import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/frames/loading.dart';

void main() {
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

