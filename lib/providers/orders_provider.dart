import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier {
  final List<ProductModel> _orders = [];
  List<ProductModel> get orders => _orders;

  void addToOrders(ProductModel product) {
    final existingIndex = _orders.indexWhere(
      (item) => product.id == item.id,
    );

    if (existingIndex == -1) {
      _orders.add(product);
    }
    notifyListeners();
  }
}
