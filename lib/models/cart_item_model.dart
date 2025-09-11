import 'product_model.dart';
import 'package:hive/hive.dart';
part 'cart_item_model.g.dart';

@HiveType(typeId: 4)
class CartItem {
  @HiveField(0)
  final ProductModel product;
  @HiveField(1)
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  num get totalPrice => product.price! * quantity;
}