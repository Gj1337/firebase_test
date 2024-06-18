import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:firebase_test/setup_notification.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupNotification();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Firebase test!'),
        ),
      ),
    );
  }
}
