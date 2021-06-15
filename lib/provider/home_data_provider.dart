import 'package:flutter/foundation.dart';

class HomeDataProvider extends ChangeNotifier {
  String? id = 'null';
  String? name = 'null';
  String? phone = 'null';
  String? address = 'null';
  String? pageId = '1';
  var json;
  bool? check = false;
  getCheck(bool value) {
    check = value;
    notifyListeners();
  }

  getArray(value) {
    json = value;
    print(json);
  }

  returnCheck() {
    return check;
  }

  getPageID(String value) {
    pageId = value;
    // notifyListeners();
  }

  returnPageID() {
    return pageId;
  }

  givePersonName(String value) {
    name = value;
    notifyListeners();
  }

  givePersonID(String value) {
    id = value;
    notifyListeners();
  }

  givePersonPhone(String value) {
    phone = value;
    notifyListeners();
  }

  givePersonAddress(String value) {
    address = value;
    notifyListeners();
  }

  returnPersonID() {
    return id!;
  }

  returnPersonName() {
    return name!;
  }

  returnPersonPhone() {
    return phone!;
  }

  returnPersonAddress() {
    return address!;
  }
}
