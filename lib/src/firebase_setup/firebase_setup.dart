import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_test/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'setup_authification.dart';
part 'setup_notification.dart';

Future<void> firebaseSetup({
  bool useEmulators = false,
}) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setupAuthentication(useAuthEmulator: useEmulators);
  await _setupNotification();
}
