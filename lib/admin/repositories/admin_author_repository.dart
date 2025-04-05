import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/author_model.dart';

class AdminAuthorRepository extends GetxController {
  static AdminAuthorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch Authors from Firestore
  Future<List<AuthorModel>> getAuthors() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('authors').get();

      return snapshot.docs.map((doc) => AuthorModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Add a new Author
  Future<void> addAuthor(AuthorModel author) async {
    try {
      await _db.collection('authors').add(author.toJson());
    } catch (e) {
      throw Exception('Error adding author: $e');
    }
  }

  // Delete Author
  Future<void> deleteAuthor(String authorId) async {
    try {
      await _db.collection('authors').doc(authorId).delete();
    } catch (e) {
      throw Exception('Error deleting author: $e');
    }
  }
}
