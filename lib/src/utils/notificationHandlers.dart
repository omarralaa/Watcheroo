import 'package:firebase_messaging/firebase_messaging.dart';

import './navigation_service.dart';
import './service_locator.dart';

class NotificationHandlers {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void handleNotifications() async {
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      //_navigate(message['data']);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      print('HERE HERE HERE HERE HERE ---------------');
      print(message['data']['screen']);
      _navigate(message['data']);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      //_navigate(message['data']);
    });
  }

  void _navigate(data) {
    final routeName = data['screen'];

    locator<NavigationService>().navigateTo(routeName, data);
  }
}
