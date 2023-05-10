import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FbNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final _notifications = FlutterLocalNotificationsPlugin();


  void requestNotificationPermission() async{
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    }else{
      print('user denied permission');
    }
  }


  Future<String> getDeviceToken() async {
    String? deviceToken = await _firebaseMessaging.getToken();
    // print('Device Token: $deviceToken');
    return deviceToken!;
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _notifications.initialize(settings);
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

}
