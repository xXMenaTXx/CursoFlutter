// SHA1: D5:86:6C:BC:FC:2E:2F:EF:AD:50:71:63:C4:EA:13:47:B5:E7:FF:F0

// Token del dispositivo: d61nghYKRNC26mgZQDUgel:APA91bGblhvNS-ZxWzwG5NXPflE3Xo4YKLJHLfjRGUdOkR5FCetiLBHVVNQmnup-sNZOOJfMLXvryxctZa0Jmr20tBendNCac-ad5PTFUuORVo8ig07N0FZdk8YGm7Ps-BuSN-R6hiaZ

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messageStrem => _messageStream.stream;

  static Future _backgroudHandler(RemoteMessage message) async {
    // Aplicacion abierta pero en segundo plano
    // print('onBackground Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future _onMessageHandler(RemoteMessage message) async {
    // Aplicacion abierta y usando
    // print('onMessage Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future _onMessageOpenApp(RemoteMessage message) async {
    // Abre la aplicacion con la notificación
    // print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp () async {

    // Push notificaitons
    await Firebase.initializeApp();
    await requestPermission();
    
    token = await FirebaseMessaging.instance.getToken();
    // print('Token $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroudHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local notifications
  }

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static closeStreams () {
    _messageStream.close();
  }
}