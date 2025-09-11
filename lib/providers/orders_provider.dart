import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OrdersProvider extends ChangeNotifier {
  final List<ProductModel> _orders = [];
  List<ProductModel> get orders => _orders;

  var box = Hive.box('ordersBox');

  void getStoredOrders() {
    if (box.isNotEmpty) {
      _orders.clear();
      _orders.addAll(
        box.get("Orders", defaultValue: []).cast<ProductModel>(),
      );
      notifyListeners();
    }
  }

  void setStoredOrders() {
    box.put("Orders", _orders);
  }

  void addToOrders(ProductModel product) {
    final existingIndex = _orders.indexWhere(
      (item) => product.id == item.id,
    );

    if (existingIndex == -1) {
      _orders.add(product);
    }
    setStoredOrders();
    notifyListeners();
  }
}
