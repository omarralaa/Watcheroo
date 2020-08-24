import 'package:get_it/get_it.dart';

import '../services/party_service.dart';
import '../services/friend_service.dart';
import './navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PartyService());
  locator.registerLazySingleton(() => FriendService());
}
