class OrderItemModel {
  final String bookId;
  String title;
  double price;
  int quantity;
  String image;

  OrderItemModel({
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

  /// Create OrderItemModel from JSON
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  /// Copy with method
  OrderItemModel copyWith({
    String? bookId,
    String? title,
    double? price,
    int? quantity,
    String? image,
  }) {
    return OrderItemModel(
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }
}
