import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/loaders.dart';
import '../../models/author_model.dart';
import '../../models/book_model.dart';

class AuthorRepository extends GetxController {
  static AuthorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> uploadDummyAuthors(List<AuthorModel> authors) async {
    try {
      final supabase = Supabase.instance.client;

      for (final author in authors) {
        // Upload photo
        String photoUrl = author.photoUrl;
        if (author.photoUrl.isNotEmpty) {
          final path =
              'author-photos/${DateTime.now().millisecondsSinceEpoch}.png';
          final file = await XFile(author.photoUrl).readAsBytes();
          await supabase.storage.from('images').uploadBinary(path, file);
          photoUrl = supabase.storage.from('images').getPublicUrl(path);
        }

        // Create author with updated photo URL
        final updatedAuthor = author.copyWith(photoUrl: photoUrl);
        await _db
            .collection('Authors')
            .doc(author.id)
            .set(updatedAuthor.toJson());
      }

      LLoaders.successSnackBar(title: 'Success', message: 'Authors uploaded');
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<AuthorModel> getAuthorById(String authorId) async {
    try {
      final snapshot = await _db.collection('Authors').doc(authorId).get();
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
              .collection('Books')
              .where('authorId', isEqualTo: authorId)
              .get();
      return snapshot.docs.map((doc) => BookModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error fetching author books: ${e.toString()}';
    }
  }
}
