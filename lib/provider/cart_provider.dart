import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CartDataItem {
  final String? id;
  final String? title;
  final String? price;
  final double? quantity;
  final String? image;
  final double? count;
  final String? idOfProducts;
  final String? isCount;
  final String? typeOfCount;
  CartDataItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
    @required this.image,
    @required this.count,
    @required this.idOfProducts,
    @required this.isCount,
    @required this.typeOfCount,
  });
}

class CartProviderData with ChangeNotifier {
  Map<String, CartDataItem> _items = {};
  Map<String, CartDataItem> get items {
    return {..._items};
  }

  giveCart() {
    return items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartDataItem) {
      total += double.parse(cartDataItem.price!) * cartDataItem.quantity!;
    });
    return total;
  }

  void addItems(
    String productId,
    String price,
    String title,
    String image,
    String count,
    String idOfProducts,
    String isCount,
    String typeOfCount,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!.toDouble() + 1,
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartDataItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1.0,
          image: image,
          count: double.parse(count),
          idOfProducts: idOfProducts,
          isCount: isCount,
          typeOfCount: typeOfCount,
        ),
      );
    }
    notifyListeners();
  }

  void decreaseCount(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!.toDouble() - 1,
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    }
    notifyListeners();
    //  else {
    //   _items.remove(productId);
    // }
  }

  void decreaseKG(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!.toDouble() - 0.2,
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    }
    notifyListeners();
    //  else {
    //   _items.remove(productId);
    // }
  }

  void increaseCount(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! < _items[productId]!.count!) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!.toDouble() + 1,
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    }
    notifyListeners();
  }

  void increaseKG(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! < _items[productId]!.count!) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity!.toDouble() + 0.2,
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateValue(String productId, String value) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartDataItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: double.parse(value),
          image: existingCartItem.image,
          count: existingCartItem.count,
          idOfProducts: existingCartItem.idOfProducts,
          isCount: existingCartItem.isCount,
          typeOfCount: existingCartItem.typeOfCount,
        ),
      );
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
  }

  notifyListeners();
}
