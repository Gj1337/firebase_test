part of "firebase_setup.dart";

Future<void> _setupAuthentication({
  bool useAuthEmulator = false,
}) async {
  if (useAuthEmulator) {
    //Use emulator for testing
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }
}
