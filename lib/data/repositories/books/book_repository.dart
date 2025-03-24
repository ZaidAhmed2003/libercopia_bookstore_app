import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/loaders.dart';
import '../../models/book_model.dart';

class BookRepository extends GetxController {
  static BookRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> uploadDummyBooks(List<BookModel> books) async {
    try {
      final supabase = Supabase.instance.client;

      for (final book in books) {
        // Upload images to Supabase
        final List<String> imageUrls = [];
        for (String imagePath in book.imageUrls) {
          final path =
              'book-images/${DateTime.now().millisecondsSinceEpoch}.png';
          final file = await XFile(imagePath).readAsBytes();
          await supabase.storage.from('images').uploadBinary(path, file);
          final imageUrl = supabase.storage.from('images').getPublicUrl(path);
          imageUrls.add(imageUrl);
        }

        // Create book with updated image URLs
        final updatedBook = book.copyWith(imageUrls: imageUrls);

        // Upload book to Firestore
        await _db.collection('Books').doc(book.id).set(updatedBook.toJson());
      }

      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Books uploaded successfully',
      );
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Error uploading books: ${e.toString()}';
    }
  }

  Future<List<BookModel>> getFeaturedBooks() async {
    try {
      final snapshot =
          await _db
              .collection('Books')
              .where('isFeatured', isEqualTo: true)
              .limit(4)
              .get();
      return snapshot.docs.map((doc) => BookModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Error fetching featured books: ${e.toString()}';
    }
  }

  Future<void> updateBookStock(String bookId, int quantity) async {
    try {
      await _db.collection('Books').doc(bookId).update({
        'stock': FieldValue.increment(-quantity),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error updating book stock: ${e.toString()}';
    }
  }

  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final snapshot =
          await _db
              .collection('Books')
              .where('title', isGreaterThanOrEqualTo: query)
              .where('title', isLessThan: '${query}z')
              .get();
      return snapshot.docs.map((doc) => BookModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error searching books: ${e.toString()}';
    }
  }
}
