import 'package:flutter/material.dart';

class CartItems {
  final String? id;
  final String? title;
  final String? price;
  late final double? quantity;
  final String? image;
  final double? count;
  final String? idOfProducts;
  final String? isCount;
  CartItems({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
    required this.count,
    required this.idOfProducts,
    required this.isCount,
  });
  CartItems copyWith({
    String? id,
    String? title,
    String? price,
    double? quantity,
    String? image,
    double? count,
    String? idOfProducts,
    String? isCount,
  }) {
    return CartItems(
      id: this.id,
      title: this.title,
      price: this.price,
      quantity: this.quantity,
      image: this.image,
      count: this.count,
      idOfProducts: this.idOfProducts,
      isCount: this.isCount,
    );
  }
}

class AppState {
  final List<CartItems>? items;
  AppState({
    required this.items,
  });
  List<CartItems>? get cart => items;
  AppState.initialState() : items = List.unmodifiable(<CartItems>[]);
}
