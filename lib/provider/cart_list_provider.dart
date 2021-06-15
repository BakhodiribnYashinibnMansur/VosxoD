// import 'package:flutter/material.dart';

// class ProductItems {
//   final String? id;
//   final String? title;
//   final String? price;
//   late final double? quantity;
//   final String? image;
//   final double? count;
//   final String? idOfProducts;
//   final String? isCount;
//   ProductItems({
//     @required this.id,
//     @required this.title,
//     @required this.price,
//     @required this.quantity,
//     @required this.image,
//     @required this.count,
//     @required this.idOfProducts,
//     @required this.isCount,
//   });
// }

// class Store extends ChangeNotifier {
//   List<ProductItems> _cart = [];
//   List<ProductItems> get cart => _cart;

//   addItemToCart(ProductItems product) {
//     ProductItems found = _cart.firstWhere((p) => p.id == product.id);
//     if (found != null) {
//       found.quantity = found.quantity! + 1;
//     } else {
//       _cart.add(product);
//       product.quantity = product.quantity! + 1;
//     }
//     print("adding ${product}");
//     notifyListeners();
//   }

//   removeItemFromCart(ProductItems product) {
//     ProductItems found = _cart.firstWhere((p) => p.id == product.id);
//     if (found != null && found.quantity == 1) {
//       product.quantity = 0;
//       _cart.remove(product);
//     }
//     if (found != null && found.quantity! > 1) {
//       found.quantity = found.quantity! - 1;
//     }
//     notifyListeners();
//   }

//   int getCartQuantity() {
//     int total = 0;
//     for (ProductItems p in _cart) {
//       total += p.quantity as int;
//     }
//     return total;
//   }

//   double getCartTotal() {
//     double price = 0;
//     for (ProductItems p in _cart) {
//       price += (double.parse(p.price.toString()) * p.quantity!);
//     }
//     return price;
//   }
// }
