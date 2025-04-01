import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistModel {
  final String id;
  final String userId;
  final String bookId;
  DateTime addedAt;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.addedAt,
  });

  /// Empty helper function
  static WishlistModel empty() =>
      WishlistModel(id: '', userId: '', bookId: '', addedAt: DateTime.now());

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bookId': bookId,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  /// Create WishlistModel from Firestore Document
  factory WishlistModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return WishlistModel(
      id: snapshot.id,
      userId: data['userId'] ?? '',
      bookId: data['bookId'] ?? '',
      addedAt: (data['addedAt'] as Timestamp).toDate(),
    );
  }
}
