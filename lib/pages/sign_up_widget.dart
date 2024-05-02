import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/input_field.dart';
import 'package:flutter_firebase/components/rich_text_custom.dart';
import 'package:flutter_firebase/components/sign_in_up_btn.dart';
import 'package:flutter_firebase/components/sign_in_up_page_alignment.dart';
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
      body: SignInUpPageAlignment(pageColumn: Column(children: <Widget>[
        SizedBox( height: 100, child: Image.asset('assets/img/firebase.png'),),
                      InputField(controller: emailController, labelText: "Email", obscureText: false, 
                      validator:  (email) => email != null && !EmailValidator.validate(email) ? "Enter valid email!": null),


                      const SizedBox(height: 12,),
                  
                      InputField(controller: passwordController, labelText: "Password", obscureText: true, 
                      validator:  (value) =>value != null && value.length < 6 
                      ? "Enter min. 6 Characters" : null),

                      const SizedBox(height: 16,),


                      SignInUpBtn(onTap: signUp, btnName: "Sign Up"),
    
                      const SizedBox(height: 14, ),


                    RichTextCustom(question: "Already have an account ?  ", action: "Login", recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn ),


      ],))
    );
  }


//  Align(
//         alignment: Alignment.center,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(40),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.6,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox( height: 100, child: Image.asset('assets/img/firebase.png'),),
//                       InputField(controller: emailController, labelText: "Email", obscureText: false, 
//                       validator:  (email) => email != null && !EmailValidator.validate(email) ? "Enter valid email!": null),
//                       const SizedBox(height: 12,),
//                       InputField(controller: passwordController, labelText: "Password", obscureText: true, 
//                       validator:  (value) =>value != null && value.length < 6 
//                       ? "Enter min. 6 Characters" : null),
//                       const SizedBox(height: 16,),
//                       SignInUpBtn(onTap: signUp, btnName: "Sign Up"),
//                       const SizedBox(height: 14, ),
//                     RichTextCustom(question: "Already have an account ?  ", action: "Login", recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),

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
