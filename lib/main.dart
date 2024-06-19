import 'package:firebase_test/src/app.dart';
import 'package:firebase_test/src/firebase_setup/firebase_setup.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await firebaseSetup(useEmulators: true);

  runApp(const App());
}
