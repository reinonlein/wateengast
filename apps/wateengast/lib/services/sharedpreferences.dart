import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  // datum vanaf wanneer de posts opgehaald moeten worden
  String get afterDate =>
      _sharedPrefs.getString('afterDate') ?? '2021-01-01T00:00:00'; // vervangen door today

  set afterDate(String value) {
    _sharedPrefs.setString('afterDate', value);
    print('set shared preferences afterDate to value: $value');
  }

  // datum vanaf wanneer de posts opgehaald moeten worden
  String get previousDate =>
      _sharedPrefs.getString('previousDate') ??
      DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()).toString();

  set previousDate(String value) {
    _sharedPrefs.setString('previousDate', value);
    print('set shared preferences previousDate to value: $value');
  }
}

final sharedPrefs = SharedPrefs();
