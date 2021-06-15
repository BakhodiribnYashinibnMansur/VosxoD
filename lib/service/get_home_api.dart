import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:VosxoD/model/cart_data_json.dart';
import 'dart:convert';

import 'package:VosxoD/model/home_data_json.dart';
import 'package:VosxoD/utils/my_prefs.dart';

class GetHomeData {
  List<HomeDataJson> parentList = [];
  late List<dynamic> dataList;
  List<HomeDataJson> get getParentList {
    return [...parentList];
  }

  getParentData() {
    getApis();
  }

  Future<List<HomeDataJson>> getApis() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/big-categories");
    try {
      final response = await http.get(
        URL,
        headers: {HttpHeaders.authorizationHeader: TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map['categories'];
        List<HomeDataJson> loadedProducts = [];
        return data.map((item) => HomeDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        List<HomeDataJson> data = map['categories'];
        return data;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<CartDataJson>> getApisId(int id) async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/parent-categories");
    var response = await http.post(URL, headers: {
      HttpHeaders.authorizationHeader: TOKEN,
    }, body: {
      "id": id,
    });
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> dataCard = map["category"];
    return dataCard.map((item) => CartDataJson.fromJson(item)).toList();
  }
}
// Map<String, dynamic> map = json.decode(response.body);
    // parentList = map["categories"] as List<HomeDataJson>;
    // data.map((item) => HomeDataJson.fromJson(item)).toList();
    // parentList = data;
    // print(HomeDataJson.fromJson(json.decode(response.body)['categories']));
    // List<HomeDataJson> loadedProducts = [];
    // loadedProducts = data;

    // data.forEach((item) {
    //   loadedProducts.add(HomeDataJson(
    //     id: item['id'],
    //     name: item['name'],
    //     parentId: item['parent_id'],
    //     bobo: item['bobo'],
    //     status: item['status'],
    //     omborId: item['ombor_id'],
    //     foiz: item['foiz'],
    //     position: item['poition'],
    //     type: item['type'],
    //   ));
    // });

        // data.map((item) {
        //   return loadedProducts.add(HomeDataJson(
        //     id: item['id'],
        //     name: item['name'],
        //     parentId: item['parent_id'],
        //     bobo: item['bobo'],
        //     status: item['status'],
        //     omborId: item['ombor_id'],
        //     foiz: item['foiz'],
        //     position: item['poition'],
        //     type: item['type'],
        //   ));
        // });
        // loadedProducts = parentList;
        // map['categories'] = dataList;
        // data = [...dataList];
        // print(loadedProducts);
        // return data;
        // setValue(data);
// class HomePageProvider extends ChangeNotifier {
//   bool _isHomePageProcessing = true;
//   List<HomeDataJson> _postsList = [];
//   bool _shouldRefresh = true;
//   bool get shouldRefresh => _shouldRefresh;
//   setShouldRefresh(bool value) => _shouldRefresh = value;
//   bool get isHomePageProcessing => _isHomePageProcessing;
//   setIsHomePageProcessing(bool value) {
//     _isHomePageProcessing = value;
//     notifyListeners();
//   }

//   List<HomeDataJson> get postsList => _postsList;
//   setPostsList(List<HomeDataJson> list, {bool notify = true}) {
//     _postsList = list;
//     if (notify) notifyListeners();
//   }

//   mergePostsList(List<HomeDataJson> list, {bool notify = true}) {
//     _postsList.addAll(list);
//     if (notify) notifyListeners();
//   }

//   addPost(HomeDataJson post, {bool notify = true}) {
//     _postsList.add(post);
//     if (notify) notifyListeners();
//   }

//   HomeDataJson getPostByIndex(int index) => _postsList[index];
//   int get postsListLength => _postsList.length;
// }
