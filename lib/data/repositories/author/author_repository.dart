import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../models/author_model.dart';
import '../../models/book_model.dart';

class AuthorRepository extends GetxController {
  static AuthorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final supabase = Supabase.instance.client;

  Future<AuthorModel?> getAuthorById(String authorId) async {
    try {
      final snapshot = await _db.collection('authors').doc(authorId).get();
      if (!snapshot.exists) return null;
      return AuthorModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error fetching author: ${e.toString()}';
    }
  }

  Future<List<BookModel>> getBooksByAuthor(String authorId) async {
    try {
      final snapshot =
          await _db
              .collection('books')
              .where('authorId', isEqualTo: authorId)
              .get();
      return snapshot.docs.map((doc) => BookModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      return [];
    }
  }
}
