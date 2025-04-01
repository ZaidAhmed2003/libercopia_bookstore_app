import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  final supabase = Supabase.instance.client;

  Future<void> uploadDummyAuthors(List<AuthorModel> authors) async {
    try {
      const int batchLimit = 500;
      List<List<AuthorModel>> authorBatches = [];

      for (int i = 0; i < authors.length; i += batchLimit) {
        authorBatches.add(
          authors.sublist(
            i,
            i + batchLimit > authors.length ? authors.length : i + batchLimit,
          ),
        );
      }

      for (final batchAuthors in authorBatches) {
        WriteBatch batch = _db.batch();

        final List<Future<void>> uploadTasks =
            batchAuthors.map((author) async {
              String photoUrl = author.photoUrl ?? '';

              if (photoUrl.isNotEmpty && !photoUrl.startsWith('http')) {
                try {
                  final path =
                      'author-photos/${DateTime.now().millisecondsSinceEpoch}.png';
                  final fileBytes = await XFile(photoUrl).readAsBytes();

                  await supabase.storage
                      .from('images')
                      .uploadBinary(path, fileBytes);
                  photoUrl = supabase.storage.from('images').getPublicUrl(path);
                } catch (e) {
                  if (kDebugMode) {
                    print(
                      'Error uploading image for ${author.name}: ${e.toString()}',
                    );
                  }
                }
              }

              final docRef = _db.collection('authors').doc(author.id);
              batch.set(docRef, author.toJson()..['photoUrl'] = photoUrl);
            }).toList();

        await Future.wait(uploadTasks);
        await batch.commit();
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
