import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignInUpPageAlignment extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Column pageColumn;
  SignInUpPageAlignment({required this.pageColumn,  super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: formKey,
                child: pageColumn
              ),
            ),
          ),
        ),
      ),
    );
  }
}
