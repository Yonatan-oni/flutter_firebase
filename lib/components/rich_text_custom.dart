import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RichTextCustom extends StatelessWidget {
  TapGestureRecognizer recognizer;
  String question;
  String action;

  RichTextCustom({ required this.question, required this.action,  super.key, required this.recognizer});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            text: question,
            children: [
          TextSpan(
              recognizer: recognizer,
              text: action,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue.shade300))
        ]));
  }
}

