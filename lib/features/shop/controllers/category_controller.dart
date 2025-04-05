import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/category_model.dart';
import 'package:libercopia_bookstore_app/data/repositories/categories/category_repository.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Load Categories Data
  Future<void> fetchCategories() async {
    try {
      // show loader while categories are being fetched
      isLoading.value = true;

      // Fetch Categories from data source (Firebase)
      final categories = await _categoryRepository.getAllCategories();

      // update the categories list with the fetched data
      allCategories.assignAll(categories);
      // filter featured categories from the list
      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => !category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
    } catch (e) {
      // Show Some Generic Error To User
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Load selected Category Data
}
