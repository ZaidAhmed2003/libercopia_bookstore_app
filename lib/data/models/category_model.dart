import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  String name;
  String image;
  bool isFeatured;
  String parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    required this.parentId,
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
    id: '',
    name: '',
    image: '',
    isFeatured: false,
    parentId: '',
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'parentId': parentId,
    };
  }

  /// Create CategoryModel from Firestore Document
  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      parentId: data['parentId'] ?? '',
    );
  }

  /// Copy with method
  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    String? parentId,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      parentId: parentId ?? this.parentId,
    );
  }
}
