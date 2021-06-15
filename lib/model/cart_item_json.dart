import 'dart:convert';

CartItemJson cartItemJsonFromJson(String str) =>
    CartItemJson.fromJson(json.decode(str));

String cartItemJsonToJson(CartItemJson data) => json.encode(data.toJson());

class CartItemJson {
  CartItemJson({
    this.id,
    this.nameUz,
    this.categoryId,
    this.status,
    this.omborId,
    this.codeProduct,
    this.productType,
    this.price,
    this.image,
    this.description,
    this.warningCount,
    this.warranty,
    this.warrantyOption,
    this.onlineShop,
  });

  int? id;
  String? nameUz;
  int? categoryId;
  int? status;
  int? omborId;
  String? codeProduct;
  int? productType;
  dynamic price;
  dynamic image;
  String? description;
  int? warningCount;
  int? warranty;
  int? warrantyOption;
  int? onlineShop;

  factory CartItemJson.fromJson(Map<String, dynamic> json) => CartItemJson(
        id: json["id"],
        nameUz: json["name_uz"],
        categoryId: json["category_id"],
        status: json["status"],
        omborId: json["ombor_id"],
        codeProduct: json["code_product"],
        productType: json["product_type"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        warningCount: json["warning_count"],
        warranty: json["warranty"],
        warrantyOption: json["warranty_option"],
        onlineShop: json["online_shop"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_uz": nameUz,
        "category_id": categoryId,
        "status": status,
        "ombor_id": omborId,
        "code_product": codeProduct,
        "product_type": productType,
        "price": price,
        "image": image,
        "description": description,
        "warning_count": warningCount,
        "warranty": warranty,
        "warranty_option": warrantyOption,
        "online_shop": onlineShop,
      };
}
