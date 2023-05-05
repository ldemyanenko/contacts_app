
import 'package:contacts_app/service/db_service.dart';
import 'package:contacts_app/service/object_box_service.dart';
import 'package:contacts_app/service/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<DBService>(() => ObjectBoxService());
  locator.registerLazySingleton<SharedPrefService>(() => SharedPrefService());

}
