class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    this.stockQuantity,
    this.discountBegin,
    this.discountEnd,
    this.prodModel,
    this.points,
    this.imageUrl,
  });

  final String? id;
  final String? name;
  final String? description;
  final double price;
  final double? oldPrice;
  final double? stockQuantity;
  final String? discountBegin;
  final String? discountEnd;
  final String? prodModel;
  final double? points;
  final String? imageUrl;
}
