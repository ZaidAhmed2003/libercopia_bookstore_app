import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AdminCategoryRepository extends GetxController {
  static AdminCategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list =
          snapshot.docs
              .map((document) => CategoryModel.fromSnapshot(document))
              .toList();
      return list;
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Create a new category
  Future<void> createCategory(CategoryModel category) async {
    try {
      await _db.collection('categories').add(category.toJson());
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(category.id)
          .update(category.toJson());
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  // Check if category is assigned to any book
  Future<bool> isCategoryAssignedToBooks(String categoryId) async {
    try {
      final snapshot =
          await _db
              .collection('books')
              .where('categoryIds', arrayContains: categoryId)
              .get();
      return snapshot
          .docs
          .isNotEmpty; // Returns true if category is assigned to books
    } catch (e) {
      throw 'Error checking category assignment: $e';
    }
  }

  // Delete a category only if it's not assigned to any books
  Future<void> deleteCategory(String categoryId) async {
    try {
      bool isAssigned = await isCategoryAssignedToBooks(categoryId);
      if (isAssigned) {
        throw 'Cannot delete category, it is assigned to one or more books.';
      }
      await _db.collection('categories').doc(categoryId).delete();
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }
}
