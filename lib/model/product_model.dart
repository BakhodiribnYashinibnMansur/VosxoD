// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ProductModel {
  ProductModel({
    @required this.products,
  });

  List<Product>? products;

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    @required this.id,
    @required this.nameUz,
    @required this.status,
    @required this.omborId,
    @required this.description,
    @required this.categoryId,
    @required this.warningCount,
    @required this.productType,
    @required this.productTypeCheck,
    @required this.price,
    @required this.codeProduct,
    @required this.image,
    @required this.warranty,
    @required this.onlineShop,
  });

  int? id;
  String? nameUz;
  int? status;
  int? omborId;
  String? description;
  String? categoryId;
  double? warningCount;
  String? productType;
  int? productTypeCheck;
  dynamic? price;
  String? codeProduct;
  String? image;
  int? warranty;
  int? onlineShop;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nameUz: json["name_uz"],
        status: json["status"],
        omborId: json["ombor_id"],
        description: json["description"],
        categoryId: json["category_id"],
        warningCount: json["warning_count"].toDouble(),
        productType: json["product_type"],
        productTypeCheck: json["product_type_check"],
        price: json["price"],
        codeProduct: json["code_product"],
        image: json["image"],
        warranty: json["warranty"],
        onlineShop: json["online_shop"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_uz": nameUz,
        "status": status,
        "ombor_id": omborId,
        "description": description,
        "category_id": categoryId,
        "warning_count": warningCount,
        "product_type": productType,
        "product_type_check": productTypeCheck,
        "price": price,
        "code_product": codeProduct,
        "image": image,
        "warranty": warranty,
        "online_shop": onlineShop,
      };
}
