import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:watcherooflutter/src/providers/party.dart';

import './navigation_service.dart';
import './service_locator.dart';

class NotificationHandlers {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  void handleNotifications(context) async {
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      await handleOnMessage(context, message);
    }, onResume: (Map<String, dynamic> message) async {
      _navigate(message['data']);
    }, onLaunch: (Map<String, dynamic> message) async {
      _navigate(message['data']);
    });
  }

  void _navigate(data) {
    final routeName = data['screen'];

    locator<NavigationService>().navigateTo(routeName, data);
  }

  Future<void> handleOnMessage(context, message) async {

    switch (message['data']['type']) {
      case 'partyInvitation':
        {
          await Provider.of<Party>(context, listen: false).getPendingParties();
        }
    }
  }
}
