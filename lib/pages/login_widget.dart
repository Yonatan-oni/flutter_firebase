import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/forgot_password_btn.dart';
import 'package:flutter_firebase/components/input_field.dart';
import 'package:flutter_firebase/components/rich_text_custom.dart';
import 'package:flutter_firebase/components/sign_in_up_btn.dart';
import 'package:flutter_firebase/components/sign_in_up_page_alignment.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/utils/account_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
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
        body: SignInUpPageAlignment(
          pageColumn: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.asset('assets/img/firebase.png'),
              ),
              InputField(
                  controller: emailController,
                  // labelText: "Email",
                  labelText: AppLocalizations.of(context)!.email,

                  obscureText: false,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          // ? "Enter valid email!"
                          ? AppLocalizations.of(context)!.emailValidator
                          : null),
              const SizedBox(
                height: 12,
              ),
              InputField(
                  controller: passwordController,
                  // labelText: "Password",
                  labelText: AppLocalizations.of(context)!.password,
                  obscureText: true,
                  validator: (value) => value != null && value.length < 6
                      // ? "Enter min. 6 Characters"
                      ? AppLocalizations.of(context)!.passwordValidator
                      : null),
              const SizedBox(
                height: 6,
              ),
              const ForgotPasswordBtn(),
              const SizedBox(
                height: 16,
              ),
              SignInUpBtn(onTap: signIn, btnName: AppLocalizations.of(context)!.signIn),
              const SizedBox(
                height: 14,
              ),
              RichTextCustom(
                // question: "No account ? ",
                // action: "Sign Up",
                
                question: AppLocalizations.of(context)!.noAccount,
                action: AppLocalizations.of(context)!.signUp,

                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignUp,
              ),
            ],
          ),
        ));


      
  }

// matrix(){
//   SignInHandler(
//       emailController: emailController,
//       passwordController: passwordController,
//       context: context);
// }
      



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
