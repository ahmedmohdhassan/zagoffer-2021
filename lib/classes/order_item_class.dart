import 'package:zagoffer/classes/cart_item_class.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartProducts;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.cartProducts,
    required this.dateTime,
  });
}
