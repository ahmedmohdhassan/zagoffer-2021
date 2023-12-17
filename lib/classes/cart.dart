import 'package:flutter/material.dart';
import 'package:zagoffer/classes/cart_item_class.dart';

class Cart with ChangeNotifier {
  Map<String?, CartItem> _items = {};
  Map<String?, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalCost {
    double total = 0;
    _items.forEach((key, CartItem cartItem) {
      total += cartItem.quantity * cartItem.price!;
    });
    return total;
  }

  void addItem(
      {String? productId, String? imageUrl, String? title, double? price}) {
    if (_items.containsKey(productId)) {
      // increase the quantity
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      // add cart item
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String? productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void increaseQuantity(String? productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
        id: existingItem.id,
        title: existingItem.title,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
        imageUrl: existingItem.imageUrl,
      ),
    );
    notifyListeners();
  }

  void decreaseQuantity(String? productId) {
    _items.update(
      productId,
      (existingItem) => CartItem(
        id: existingItem.id,
        title: existingItem.title,
        price: existingItem.price,
        quantity: existingItem.quantity - 1,
        imageUrl: existingItem.imageUrl,
      ),
    );
    notifyListeners();
  }
}
