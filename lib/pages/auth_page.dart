import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login_widget.dart';
import 'package:flutter_firebase/pages/sign_up_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginWidget(onClickedSignUp: toggle) : SignUpWidget(onClickedSignIn: toggle);

  
  void toggle() => setState(() => isLogin = !isLogin);
}
