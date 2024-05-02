import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/forgot_password_page.dart';

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
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
                    );
  }
}