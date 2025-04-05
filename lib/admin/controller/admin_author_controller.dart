import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libercopia_bookstore_app/admin/repositories/admin_author_repository.dart';
import 'package:libercopia_bookstore_app/data/models/author_model.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/network_manager.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';
import '../utils/image_upload_helper.dart';

class AdminAuthorController extends GetxController {
  static AdminAuthorController get instance => Get.find();

  final _authorRepository = Get.put(AdminAuthorRepository());
  final name = TextEditingController();
  final bio = TextEditingController();
  GlobalKey<FormState> addAuthorFormKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  // Observable Image Path (for UI updates)
  var imagePath = ''.obs;

  // Observable list of categories
  var authors = <AuthorModel>[].obs;

  // Observable variable for refreshing data
  var refreshData = false.obs;

  // Fetch all Authors
  Future<void> getAuthors() async {
    try {
      final result = await _authorRepository.getAuthors();
      authors.assignAll(result);
      refreshData.value = !refreshData.value;
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to load categories',
      );
    }
  }

  // Add a new Author
  Future<void> addAuthor() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Adding Author',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      if (!await NetworkManager.instance.isConnected()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Validate Form Fields
      if (!addAuthorFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Upload image if available
      String? imageUrl = '';
      if (imagePath.value.isEmpty) {
        LLoaders.errorSnackBar(
          title: 'Error',
          message: 'Please upload an image.',
        );
        return;
      } else {
        imageUrl = await SupabaseHelper.uploadImageToSupabase(
          imagePath.value,
          'authors-images',
        );
      }

      // create author model
      final author = AuthorModel(
        id: '',
        name: name.text.trim(),
        bio: bio.text.trim(),
        photoUrl: imageUrl ?? '',
        createdAt: DateTime.now(),
      );

      // save data to firestore
      await _authorRepository.addAuthor(author);
      await getAuthors();

      LFullScreenLoader.stopLoading();
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Address added successfully',
      );

      refreshData.toggle();
      resetFormFields();
      Get.back();
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: 'Failed to add category');
      LFullScreenLoader.stopLoading();
    }
  }

  // Delete a Author
  Future<void> deleteAuthor(String authorId) async {
    try {
      bool shouldDelete = await _showDeleteDialog();
      if (shouldDelete) {
        await _authorRepository.deleteAuthor(authorId);
        await SupabaseHelper.deleteImageFromSupabase(authorId);
        getAuthors();
        LLoaders.successSnackBar(title: 'Success', message: 'Author deleted');
      }
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to delete Author',
      );
    }
  }

  // Delete confirmation dialog
  Future<bool> _showDeleteDialog() async {
    return await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text('Are you sure you want to delete this Author?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Allow user to pick an image for the Author
  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Updates UI
    }
  }

  // Refresh Author data
  Future<void> refreshAuthors() async {
    await getAuthors();
  }

  @override
  void onInit() {
    super.onInit();
    getAuthors();
  }

  void resetFormFields() {
    name.clear();
    bio.clear();
    imagePath.value = '';
  }
}
