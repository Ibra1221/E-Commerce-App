import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import 'package:hive/hive.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartitems => _cartItems;
  var box = Hive.box('cartBox');

  void getStoredItems() {
    if (box.isNotEmpty) {
      _cartItems.clear();
      _cartItems.addAll(
        box.get("Cart Items", defaultValue: []).cast<CartItem>(),
      );
      notifyListeners();
    }
  }

  void setStoredItems() {
    box.put("Cart Items", _cartItems);
  }

  void addToCart(ProductModel product, int quantity) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
    setStoredItems();
    notifyListeners();
  }

  void removeFromCart(ProductModel product, int quantity) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity -= quantity;
      if (_cartItems[existingIndex].quantity == 0) {
        _cartItems.removeAt(existingIndex);
      }
    } else {
      return;
    }
    setStoredItems();
    notifyListeners();
  }

  int getProductsQuantity() {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  num getTotalPrice() {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  num getDiscount() {
    return _cartItems.fold(
      0,
      (discount, item) =>
          discount + item.totalPrice * item.product.discountPercentage! / 100,
    );
  }

  num getFinalPrice() {
    return getTotalPrice() - getDiscount();
  }
}
