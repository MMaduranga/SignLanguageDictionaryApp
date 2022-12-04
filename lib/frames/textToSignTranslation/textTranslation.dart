// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class TextTranslation extends StatelessWidget {
  final phraseController = TextEditingController();

  final Function textToSignTranslation;

  void onSubmitted() {
    textToSignTranslation(phraseController.text);
  }

  TextTranslation(this.textToSignTranslation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 50,
            color: primaryTeal.withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (_) => onSubmitted(),
              controller: phraseController,
              decoration: InputDecoration(
                hintText: "Type here...",
                hintStyle: TextStyle(color: primaryTeal.withOpacity(0.5)),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: onSubmitted,
              child: SvgPicture.asset("assets/icons/search.svg")
          ),
        ],
      ),
    );
  }
}
