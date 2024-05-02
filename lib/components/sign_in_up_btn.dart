import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignInUpBtn extends StatelessWidget {
  void Function()? onTap;
  String btnName;

  SignInUpBtn({required this.onTap, required this.btnName, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(6)),
        child:  Center(
            child: Text(
              btnName,
              style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
