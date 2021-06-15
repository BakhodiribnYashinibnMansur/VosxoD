import 'package:get_storage/get_storage.dart';

class MyPref {
  static final prefs = GetStorage();
  static get token => prefs.read('TOKEN');
  static set token(dynamic value) => prefs.write('TOKEN', value);
}

class AccountImage {
  static final pref = GetStorage();
  static get image => pref.read('IMAGE');
  static set image(dynamic value) => pref.write('IMAGE', value);
}

class PassCode {
  static final pref = GetStorage();
  static get passcode => pref.read('PASSCODE');
  static set passcode(dynamic value) => pref.write('PASSCODE', value);
}

// class ProductList {
//   static final pref = GetStorage();
//   static get mylist => pref.read('MYLIST');
//   static set mylist(List<DataSqlite> values) => pref.write('MYLIST', values);
// }
