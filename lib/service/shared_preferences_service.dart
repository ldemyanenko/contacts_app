import 'package:shared_preferences/shared_preferences.dart';

const String _KEY_IS_DB_INITIALISED = "key_is_db_initialised";

class SharedPrefService {
  late SharedPreferences _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveIsDbInitialised(bool value) {
    _prefs.setBool(_KEY_IS_DB_INITIALISED, value);
  }

  bool readIsDbInitialised() {
    return _prefs.getBool(_KEY_IS_DB_INITIALISED) ?? false;
  }
}
