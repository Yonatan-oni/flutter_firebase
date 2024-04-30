import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/utils/account_util.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpWidget({super.key, required this.onClickedSignIn});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: Image.asset('assets/img/firebase.png'),
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Email ',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade300),
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? "Enter valid email!"
                                : null,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? "Enter min. 6 Characters"
                            : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                     
          
                      GestureDetector(
                        onTap: signUp,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                              child: Text(
                            "Sign Up",
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
                              text: "Already have an account ?  ",
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickedSignIn,
                                text: "Login",
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
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      AccountUtil.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
