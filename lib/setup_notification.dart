import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> setupNotification() async {
  await FirebaseMessaging.instance.requestPermission();

  final fcmToken = await FirebaseMessaging.instance.getToken();

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
