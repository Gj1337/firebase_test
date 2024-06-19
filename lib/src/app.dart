import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/src/feature/authorization/login_screen/login_screen.dart';
import 'package:firebase_test/src/feature/main_screen/main_screen.dart';
import 'package:firebase_test/src/feature/authorization/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      routerConfig: _router,
    );
  }
}
