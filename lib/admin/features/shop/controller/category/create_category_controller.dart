import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/category_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageUrl = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Method To Reset Fields
  /// Pick Thumbnail For Image form Media
  /// Register New Category
  Future<void> createCategory() async {}
}
