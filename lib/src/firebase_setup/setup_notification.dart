// ignore_for_file: avoid_print

part of 'firebase_setup.dart';

Future<void> _setupNotification() async {
  FirebaseMessaging.instance.requestPermission();

  final fcmToken = await FirebaseMessaging.instance.getToken(
    vapidKey:
        "BM5B74cHBldMOJRPSVmnGvTbvXFepK2Kf8y6-N3qOezT02Fc2MwZd1mF3R3O__7BxSOunBZdkKgwRpK10QKYPH4",
  );

  print('fcmToken = $fcmToken\r\n');

  // Setup android notification channel
  // for high priority notifications

  const channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
    ),
  );

  // Processing notification in foreground

  FirebaseMessaging.onMessage.listen(
    (message) {
      print(
        '\r\n'
        '🔔 ${message.notification?.title}'
        '\r\n '
        '   ${message.notification?.body}'
        '\r\n ',
      );

      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
            ),
          ),
        );
      }
    },
  );
}
