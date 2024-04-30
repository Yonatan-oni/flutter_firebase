import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/pages/forgot_password_page.dart';
import 'package:flutter_firebase/utils/account_util.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  // const LoginWidget({Key? key, required this.onClickedSignUp } ) : super (key:key);
  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Image.asset('assets/img/firebase.png'),
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: 'Email ',
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade300),
                          ),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password ',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade300),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordPage())),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: signIn,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Center(
                            child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            text: "No account ?  ",
                            children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: "Sign Up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue.shade300))
                        ])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      AccountUtil.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
