import 'package:firebase_test/src/feature/authorization/sign_up_screen/widget/sign_up_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: SignUpWidget()),
    );
  }
}
