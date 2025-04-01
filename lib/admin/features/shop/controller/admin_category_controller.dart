import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../../../data/models/category_model.dart';
import '../../../../utils/helpers/image_upload_helper.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/admin_category_repository.dart';

class AdminCategoryController extends GetxController {
  static AdminCategoryController get instance => Get.find();

  final _categoryRepository = Get.put(AdminCategoryRepository());
  final name = TextEditingController();
  final _imagePicker = ImagePicker();

  // Observable Image Path (for UI updates)
  var imagePath = ''.obs;

  GlobalKey<FormState> addCategoryFormKey = GlobalKey<FormState>();

  // Observable list of categories
  var categories = <CategoryModel>[].obs;

  // Observable variable for refreshing data
  var refreshData = false.obs;

  // Fetch all categories
  Future<void> getCategories() async {
    try {
      final result = await _categoryRepository.getAllCategories();
      categories.assignAll(result);
      refreshData.value = !refreshData.value;
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load categories',
      );
    }
  }

  // Add a new category
  Future<void> addCategory() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addCategoryFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Upload image if available
      String imageUrl = '';
      if (imagePath.value.isNotEmpty) {
        imageUrl = await ImageUploadHelper.uploadImage(
          imagePath.value,
          'category-images',
        );
      }

      // Create category model
      final category = CategoryModel(
        id: '',
        name: name.text,
        image: imageUrl,
        isFeatured: false,
        parentId: '',
        createdAt: DateTime.now(),
      );

      await _categoryRepository.createCategory(category);
      getCategories();

      // Reset form and image path
      name.clear();
      imagePath.value = '';

      LLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your category has been created successfully.',
      );

      // Get Back
      Get.back();
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: 'Failed to add category');
    } finally {
      LFullScreenLoader.stopLoading();
    }
  }

  // Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _categoryRepository.updateCategory(category);
      getCategories();
      LLoaders.successSnackBar(title: 'Success', message: 'Category updated');
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update category',
      );
    }
  }

  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      bool shouldDelete = await _showDeleteDialog();
      if (shouldDelete) {
        await _categoryRepository.deleteCategory(categoryId);
        getCategories();
        LLoaders.successSnackBar(title: 'Success', message: 'Category deleted');
      }
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to delete category',
      );
    }
  }

  // Delete confirmation dialog
  Future<bool> _showDeleteDialog() async {
    return await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text(
              'Are you sure you want to delete this category?',
            ),
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

  // Allow user to pick an image for the category
  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path; // Updates UI
    }
  }

  // Refresh categories data
  Future<void> refreshCategories() async {
    await getCategories();
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
}
