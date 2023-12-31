import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String? title;
  final int quantity;
  final double? price;
  final String? imageUrl;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
}
