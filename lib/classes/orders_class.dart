import 'package:flutter/cupertino.dart';
import 'package:zagoffer/classes/cart_item_class.dart';
import 'package:zagoffer/classes/order_item_class.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        cartProducts: cartProducts,
      ),
    );
    notifyListeners();
  }
}
