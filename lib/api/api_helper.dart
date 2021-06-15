// import 'dart:convert';
// import 'dart:io';
// import 'package:VosxoD/model/home_data_json.dart';
// import 'package:VosxoD/model/http_response.dart';
// import 'package:VosxoD/utils/my_prefs.dart';
// import 'package:http/http.dart' as http;

// class APIHelper {
//   static Future<HTTPResponse<List<HomeDataJson>>> getPosts() async {
//     try {
//       final TOKEN = MyPref.token;
//       Uri URL = Uri.parse("https://vosxod.uz/api/big-categories");
//       var response = await http.get(
//         URL,
//         headers: {HttpHeaders.authorizationHeader: TOKEN},
//       );
//       if (response.statusCode == 200) {
//         var body = jsonDecode(response.body);
//         Map<String, dynamic> map = json.decode(response.body);
//         List<dynamic> data = map["categories"];
//         data.map((item) => HomeDataJson.fromJson(item)).toList();
//         return HTTPResponse<List<HomeDataJson>>(
//           true,
//           data,
//           message: 'Request Successful',
//           statusCode: response.statusCode,
//         );
//       } else {
//         return HTTPResponse<List<HomeDataJson>>(
//           false,
//           null,
//           message:
//               'Invalid data received from the server! Please try again in a moment.',
//           statusCode: response.statusCode,
//         );
//       }
//     } on SocketException {
//       print('SOCKET EXCEPTION OCCURRED');
//       return HTTPResponse<List<HomeDataJson>>(
//         false,
//         null,
//         message: 'Unable to reach the internet! Please try again in a moment.',
//       );
//     } on FormatException {
//       print('JSON FORMAT EXCEPTION OCCURRED');
//       return HTTPResponse<List<HomeDataJson>>(
//         false,
//         null,
//         message:
//             'Invalid data received from the server! Please try again in a moment.',
//       );
//     } catch (e) {
//       print('UNEXPECTED ERROR');
//       print(e.toString());
//       return HTTPResponse<List<HomeDataJson>>(
//         false,
//         null,
//         message: 'Something went wrong! Please try again in a moment!',
//       );
//     }
//   }
// }
