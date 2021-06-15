import 'package:flutter/material.dart';

class HomeDataItems {
  final String? name;
  final String? id;
  HomeDataItems({required this.name, required this.id});
}

class FutureHomeData with ChangeNotifier {
  Map<String, HomeDataItems> _items = {};
  Map<String, HomeDataItems> get items {
    return {..._items};
  }

  giveHomeData() {
    return items;
  }

  int get dataLength {
    return _items.length;
  }

  void addItems(String name, String id) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingCartItem) => HomeDataItems(
          id: existingCartItem.id,
          name: existingCartItem.name,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => HomeDataItems(
          id: id,
          name: name,
        ),
      );
    }
    notifyListeners();
  }
}
