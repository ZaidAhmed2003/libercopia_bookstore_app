class CartItemModel {
  final String bookId;
  String title;
  double price;
  int quantity;
  String image;

  CartItemModel({
    required this.bookId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  /// Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  /// Copy with method
  CartItemModel copyWith({
    String? bookId,
    String? title,
    double? price,
    int? quantity,
    String? image,
  }) {
    return CartItemModel(
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }
}
