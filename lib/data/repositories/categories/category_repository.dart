import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libercopia_bookstore_app/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/popups/loaders.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _supabase = Supabase.instance.client;

  /// Get all Categories
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

  /// upload Dummy Data
  Future<void> uploadDummyCategories(List<CategoryModel> categories) async {
    try {
      const int batchLimit = 500;
      final List<List<CategoryModel>> categoryBatches = _splitIntoBatches(
        categories,
        batchLimit,
      );

      for (final batchCategories in categoryBatches) {
        WriteBatch batch = _db.batch();
        final List<Future<void>> uploadTasks =
            batchCategories.map((category) async {
              final String imageUrl = await _uploadImageIfNeeded(
                category.image,
              );
              final docRef = _db.collection('categories').doc(category.id);
              batch.set(docRef, category.toJson()..['image'] = imageUrl);
            }).toList();

        await Future.wait(uploadTasks);
        await batch.commit();
      }

      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Categories uploaded successfully',
      );
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Splits a list into batches of the given size
  List<List<CategoryModel>> _splitIntoBatches(
    List<CategoryModel> items,
    int batchSize,
  ) {
    List<List<CategoryModel>> batches = [];
    for (int i = 0; i < items.length; i += batchSize) {
      batches.add(
        items.sublist(
          i,
          (i + batchSize > items.length) ? items.length : i + batchSize,
        ),
      );
    }
    return batches;
  }

  /// Uploads an image to Supabase if it's a local path
  Future<String> _uploadImageIfNeeded(String imageUrl) async {
    if (imageUrl.isEmpty || imageUrl.startsWith('http')) return imageUrl;

    try {
      final XFile pickedFile = XFile(imageUrl);
      final fileBytes = await pickedFile.readAsBytes();
      final storagePath =
          'category-images/${DateTime.now().millisecondsSinceEpoch}.png';

      await _supabase.storage
          .from('images')
          .uploadBinary(
            storagePath,
            fileBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return _supabase.storage.from('images').getPublicUrl(storagePath);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Supabase upload error: $e');
      }
      return ''; // Return empty string if upload fails
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error during image upload: $e');
      }
      return ''; // Fallback
    }
  }
}
