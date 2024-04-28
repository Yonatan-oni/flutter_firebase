import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email '),
          ),
          SizedBox(
            height: 4,
          ),
          TextField(
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Password '),
          ),
          // ElevatedButton(child: Text('data'), onPressed: signIn)
        ],
      ),
    );
  }

  void signIn() {
    print("hello");
  }
}
