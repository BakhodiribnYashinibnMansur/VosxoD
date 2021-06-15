// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'package:VosxoD/screen/home_screen.dart';
// import 'package:VosxoD/utils/my_prefs.dart';

// class LoginData {
//   String login;
//   String parol;
//   LoginData({
//     this.login,
//     this.parol,
//   });
// }

// final url = Uri.parse("https://vosxod.uz/api/login");

// class LoginProvider with ChangeNotifier {
//   getAuth(String email, String password) async {
//     Map<String, dynamic> mapDataR = {"parol": password, "login": email};
//     final jsonDataR = JsonEncoder().convert(mapDataR);
//     var response = await http.post(url, body: jsonDataR);
//     return response;
//     //   var jsonResponse = null;
//     //   if (response.statusCode == 200) {
//     //     jsonResponse = jsonDecode(response.body);
//     //     if (jsonResponse != null) {
//     //       _isLoading = false;
//     //     }
//     //     sharedPreferences.setString("token", jsonResponse['token']);
//     //     Navigator.of(context).pushAndRemoveUntil(
//     //         MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
//     //         (Route<dynamic> route) => false);
//     //     notifyListeners();
//     //   } else {
//     //     _isLoading = false;
//     //     print(response.body);
//     //     notifyListeners();
//     //   }
//     //   notifyListeners();
//     // }

//     // bool _isLoading = false;
//     // isLoadingTr() {
//     //   _isLoading = true;
//     //   notifyListeners();
//     // }

//     // getIsLoading() {
//     //   return _isLoading;
//   }
// }
