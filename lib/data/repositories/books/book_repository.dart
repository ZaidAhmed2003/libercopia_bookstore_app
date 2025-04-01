import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/loaders.dart';
import '../../models/author_model.dart';
import '../../models/book_model.dart';
import '../../models/category_model.dart';

class BookRepository extends GetxController {
  static BookRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Upload Dummy Books to Firestore
  Future<void> uploadDummyBooks(List<BookModel> books) async {
    try {
      final supabase = Supabase.instance.client;
      WriteBatch batch = _db.batch();

      for (final book in books) {
        final List<String> imageUrls = [];

        for (String imagePath in book.imageUrls) {
          String imageUrl = imagePath;

          // Upload only if it's a local file path
          if (imagePath.isNotEmpty && !imagePath.startsWith('http')) {
            try {
              final path =
                  'book-images/${DateTime.now().millisecondsSinceEpoch}.png';
              final fileBytes = await XFile(imagePath).readAsBytes();
              await supabase.storage
                  .from('images')
                  .uploadBinary(path, fileBytes);
              imageUrl = supabase.storage.from('images').getPublicUrl(path);
            } catch (e) {
              if (kDebugMode) {
                print('Error uploading image for ${book.title}: $e');
              }
            }
          }

          imageUrls.add(imageUrl);
        }

        final updatedBook =
            book.toJson()
              ..['imageUrls'] = imageUrls
              ..['authorId'] = book.author.id
              ..['categoryId'] = book.category.id;
        book.author.id; // ✅ Store only `authorId` in Firestore

        // Add to Firestore batch
        final docRef = _db.collection('books').doc(book.id);
        batch.set(docRef, updatedBook);
      }

      await batch.commit(); // Commit all changes in batch
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Books uploaded successfully',
      );
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Error uploading books: ${e.toString()}';
    }
  }

  /// Fetch Full Book Data (Includes Author)
  Future<List<BookModel>> _fetchBooks(QuerySnapshot snapshot) async {
    try {
      final List<BookModel> books = [];

      for (var doc in snapshot.docs) {
        BookModel book = BookModel.fromSnapshot(doc);

        // Fetch author details
        final authorSnapshot =
            await _db.collection('authors').doc(doc['authorId']).get();

        //Fetch Category Details
        final categorySnapshot =
            await _db.collection('categories').doc(doc['categoryId']).get();

        //Combine Data
        if (authorSnapshot.exists) {
          book = BookModel(
            id: book.id,
            title: book.title,
            description: book.description,
            isbn: book.isbn,
            price: book.price,
            stock: book.stock,
            author: AuthorModel.fromSnapshot(authorSnapshot),
            category: CategoryModel.fromSnapshot(categorySnapshot),
            imageUrls: book.imageUrls,
            publishedDate: book.publishedDate,
            publisher: book.publisher,
            language: book.language,
            pages: book.pages,
            rating: book.rating,
            reviewsCount: book.reviewsCount,
            createdAt: book.createdAt,
            isFeatured: book.isFeatured,
          );
        }

        books.add(book);
      }

      return books;
    } catch (e) {
      throw 'Error fetching book details: ${e.toString()}';
    }
  }

  /// Fetch a Single Book by ID (Includes Author Details)
  Future<BookModel?> getBookById(String bookId) async {
    try {
      final doc = await _db.collection('books').doc(bookId).get();

      if (!doc.exists) return null;

      BookModel book = BookModel.fromSnapshot(doc);

      // Fetch author details
      final authorSnapshot =
          await _db.collection('authors').doc(doc['authorId']).get();

      //Fetch Category Details
      final categorySnapshot =
          await _db.collection('categories').doc(doc['categoryId']).get();

      if (authorSnapshot.exists) {
        book = BookModel(
          id: book.id,
          title: book.title,
          description: book.description,
          isbn: book.isbn,
          price: book.price,
          stock: book.stock,
          author: AuthorModel.fromSnapshot(authorSnapshot),
          category: CategoryModel.fromSnapshot(categorySnapshot),
          imageUrls: book.imageUrls,
          publishedDate: book.publishedDate,
          publisher: book.publisher,
          language: book.language,
          pages: book.pages,
          rating: book.rating,
          reviewsCount: book.reviewsCount,
          createdAt: book.createdAt,
          isFeatured: book.isFeatured,
        );
      }

      return book;
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error fetching book by ID: ${e.toString()}';
    }
  }

  /// Fetch Featured Books with Pagination
  Future<List<BookModel>> getFeaturedBooks({int limit = 4}) async {
    try {
      final snapshot =
          await _db
              .collection('books')
              .where('isFeatured', isEqualTo: true)
              .limit(limit)
              .get();

      return await _fetchBooks(snapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Error fetching featured books: ${e.toString()}';
    }
  }

  /// Fetch All Books
  Future<List<BookModel>> getAllBooks() async {
    try {
      final snapshot = await _db.collection('books').get();
      return await _fetchBooks(snapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Error fetching all books: ${e.toString()}';
    }
  }

  /// Update Book Stock
  Future<void> updateBookStock(String bookId, int quantity) async {
    try {
      await _db.collection('books').doc(bookId).update({
        'stock': FieldValue.increment(-quantity),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error updating book stock: ${e.toString()}';
    }
  }

  /// Search Books by Title (Includes Author)
  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final snapshot =
          await _db.collection('books').orderBy('title').startAt([query]).endAt(
            ['$query\uf8ff'],
          ).get();

      return await _fetchBooks(snapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } catch (e) {
      throw 'Error searching books: ${e.toString()}';
    }
  }

  Future<List<BookModel>> getBooksByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      return await _fetchBooks(querySnapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while getting books. Please try again';
    }
  }
}
