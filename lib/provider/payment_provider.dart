import 'package:flutter/foundation.dart';

class PaymentProvider extends ChangeNotifier {
  String? amount;
  String? cashPrice;
  String? bankPrice;
  String? terminalPrice;
  String? p2pPrice;
  String? currencyPrice;
  String? doubtePrice;

  getAmount(String value) {
    amount = value;
    notifyListeners();
  }

  getCashPrice(String value) {
    cashPrice = value;
    notifyListeners();
  }

  getBankPrice(String value) {
    bankPrice = value;
    notifyListeners();
  }

  getTerminalPrice(String value) {
    terminalPrice = value;
    notifyListeners();
  }

  getP2PPrice(String value) {
    p2pPrice = value;
    notifyListeners();
  }

  getCurrencyPrice(String value) {
    currencyPrice = value;
    notifyListeners();
  }

  getDoubtePrice(String value) {
    doubtePrice = value;
    notifyListeners();
  }

  bool getSucceed() {
    if (cashPrice!.contains('-')) {
      return true;
    } else {
      return false;
    }
  }

  // returnCashPrice() {
  //   int cashPro = int.parse(amount) -
  //       int.parse(bankPrice ?? '0') -
  //       int.parse(terminalPrice ?? '0') -
  //       int.parse(p2pPrice ?? '0') -
  //       int.parse(currencyPrice ?? '0') -
  //       int.parse(doubtePrice ?? '0');
  //   return cashPro.toString();
  // }

  returnDoubte() {
    int doubte = int.parse(amount!) -
        int.parse(bankPrice ?? '0') -
        int.parse(terminalPrice ?? '0') -
        int.parse(p2pPrice ?? '0') -
        int.parse(cashPrice ?? '0') -
        int.parse(currencyPrice ?? '0');
    return doubte.toString();
  }

  returnAmount() {
    return amount;
  }
}
