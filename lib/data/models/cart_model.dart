import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item_model.dart';

class CartModel {
  final String userId;
  List<CartItemModel> items;
  DateTime updatedAt;

  CartModel({
    required this.userId,
    required this.items,
    required this.updatedAt,
  });

  /// Empty Helper Function
  static CartModel empty() =>
      CartModel(userId: '', items: [], updatedAt: DateTime.now());

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Create CartModel from Firestore Document
  factory CartModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CartModel(
      userId: data['userId'] ?? '',
      items:
          (data['items'] as List<dynamic>)
              .map((item) => CartItemModel.fromJson(item))
              .toList(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// Copy with method
  CartModel copyWith({
    String? userId,
    List<CartItemModel>? items,
    DateTime? updatedAt,
  }) {
    return CartModel(
      userId: userId ?? this.userId,
      items: items ?? List.from(this.items),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
