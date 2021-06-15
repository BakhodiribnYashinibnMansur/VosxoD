// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';

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

// class SaveProduct {
//   List<ProductItems> _products = [];

//   final box = GetStorage();
//   // list of maps gets stored here
//   // separate list for storing maps/ restoreTask function
//   //populates _tasks from this list on initState

//   List storageList = [];

//   void addAndSave(ProductItems product) {
//     _products.add(product);
//     // final storageMap = {}; // temporary map that gets added to storage
//     // final index = _products.length; // for unique map keys
//     // final nameKey = 'name$index';
//     // final descriptionKey = 'description$index';
//     // adding task properties to temporary map
//     // storageMap[nameKey] = product.title;
//     // storageMap[descriptionKey] = product.id;
//     storageList.add(
//       ProductItems(
//         id: product.id.toString(),
//         title: product.title,
//         price: product.price,
//         quantity: 1.0,
//         image: product.image,
//         count: double.parse(product.count.toString()),
//         idOfProducts: product.idOfProducts,
//         isCount: product.isCount,
//       ),
//     );
//     // adding temp map to storageList
//     box.write('store', storageList);
//   }

//   readStore() {
//     return box.read('store');
//   }

//   returnLength() {
//     return _products.length;
//   }
// }
