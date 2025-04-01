import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final String parentId;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    required this.parentId,
    required this.createdAt,
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
    id: '',
    name: '',
    image: '',
    isFeatured: false,
    parentId: '',
    createdAt: DateTime.now(),
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'parentId': parentId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Create CategoryModel from Firestore Document
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    return CategoryModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: (data['isFeatured'] ?? false) as bool,
      parentId: data['parentId']?.toString() ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
