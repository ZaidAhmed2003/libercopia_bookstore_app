import 'package:cloud_firestore/cloud_firestore.dart';
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

  /// Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
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
      // upload all the categories along with their images
      final supabase = Supabase.instance.client;

      // Loop through each category
      for (final category in categories) {
        final path =
            'category-images/${DateTime.now().millisecondsSinceEpoch}.png';
        if (category.image.isNotEmpty) {
          try {
            final file = await XFile(category.image).readAsBytes();
            await supabase.storage.from('images').uploadBinary(path, file);

            final String imageUrl = supabase.storage
                .from('images')
                .getPublicUrl(path);

            category.image = imageUrl;
          } catch (e) {
            print('Error when uploading the Image $e');
          }
          await _db
              .collection('Categories')
              .doc(category.id)
              .set(
                category.toJson(),
              ); // we always update the category even if there is no image
        } else {
          print('The Category Image is Empty');
          await _db
              .collection('Categories')
              .doc(category.id)
              .set(category.toJson());
        }
      }
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Categories Uploaded Successfully',
      );
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
