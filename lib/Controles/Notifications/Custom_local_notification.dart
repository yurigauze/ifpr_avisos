import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel chanel;

  CustomLocalNotification() {
    chanel = const AndroidNotificationChannel(
      'high_importance_channel',
      'Avisos',
      description: 'Canal usado para notificações importantes',
      importance: Importance.max,
    );

    _configuraAndroid().then(
      (value) {
        flutterLocalNotificationsPlugin = value;
        inicializedNotifications();
      },
    );
  }

  Future<FlutterLocalNotificationsPlugin> _configuraAndroid() async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(chanel);

    return flutterLocalNotificationsPlugin;
  }

  inicializedNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    flutterLocalNotificationsPlugin
        .initialize(InitializationSettings(android: android));
  }

  androidNotification(
    RemoteNotification notification,
    AndroidNotification android,
  ) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          chanel.id,
          chanel.name,
          channelDescription: chanel.description,
          icon: android.smallIcon,
        )));
  }
}
