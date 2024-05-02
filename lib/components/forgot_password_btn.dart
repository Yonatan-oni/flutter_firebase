import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_firebase/pages/forgot_password_page.dart';

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({super.key});


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPasswordPage())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: const TextStyle(color: Colors.black87),

                              // 'Forgot Password ?',
                            ),
                          ),
                        ],
                      ),
                    );
  }
}