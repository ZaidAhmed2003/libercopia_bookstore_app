import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  ///  Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: 'id', name: 'name', image: 'image', isFeatured: false);

  /// convert model to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'isFeatured': isFeatured,
  };

  /// map Json oriented Document snapshot from firebase to UserModel
  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['parentId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
