import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then(
              (_) {
                context.goNamed(Routes.loginScreen.name);
              },
            );
          },
          child: const Text('Log out'),
        ),
      ),
    );
  }
}
