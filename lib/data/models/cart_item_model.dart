class CartItemModel {
  String bookId;
  String title;
  double price;
  int quantity;
  String image;
  String authorId;

  CartItemModel({
    required this.bookId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
    required this.authorId,
  });

  /// Empty Cart Helper
  static CartItemModel empty() => CartItemModel(
    bookId: '',
    title: '',
    price: 0,
    quantity: 0,
    image: '',
    authorId: '',
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
      'authorId': authorId,
    };
  }

  /// Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      price: json['price']?.toDouble(),
      quantity: json['quantity'] ?? 0,
      image: json['image'] ?? '',
      authorId: json['authorId'] ?? '',
    );
  }
}
