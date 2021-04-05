import 'package:get_it/get_it.dart';

import 'package:randomsampleapp/services/firebase_database_service.dart';

GetIt serviceLocator = GetIt.instance;

void setUpLocator() {
  serviceLocator.registerLazySingleton<FirebaseDatabaseService>(
      () => FirebaseDatabaseService());
}
