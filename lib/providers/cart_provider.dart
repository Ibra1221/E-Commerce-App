import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartitems => _cartItems;

  void addToCart(ProductModel product, int quantity) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
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
          discount + item.totalPrice * item.product.discountPercentage!/100,
    );
  }

  num getFinalPrice() {
    return getTotalPrice() - getDiscount();
  }
}
