import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../../data/models/author_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../data/repositories/admin_author_repository.dart';
import '../../../data/repositories/admin_book_repository.dart';
import '../../../data/repositories/admin_category_repository.dart';

class AdminBookController extends GetxController {
  static AdminBookController get instance => Get.find();

  final isLoading = false.obs;
  final _adminBookRepository = Get.put(AdminBookRepository());
  final _adminCategoryRepository = Get.put(AdminCategoryRepository());
  final _adminAuthorRepository = Get.put(AdminAuthorRepository());

  // Variables
  final title = TextEditingController();
  final isbn = TextEditingController();
  final price = TextEditingController();
  final stock = TextEditingController();
  final description = TextEditingController();
  final selectedCategory = Rxn<CategoryModel>();
  final selectedAuthor = Rxn<AuthorModel>();
  GlobalKey<FormState> addBookFormKey = GlobalKey<FormState>();

  final RxList<BookModel> allBooks = <BookModel>[].obs;
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<AuthorModel> allAuthors = <AuthorModel>[].obs;

  @override
  void onInit() {
    fetchAllBooks();
    fetchCategories();
    fetchAuthors();
    super.onInit();
  }

  // Fetch All Books (Admin Only)
  Future<void> fetchAllBooks() async {
    if (allBooks.isNotEmpty) return;
    try {
      isLoading.value = true;
      final books = await _adminBookRepository.getAllBooks();
      allBooks.assignAll(books);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Categories (Admin Only)
  Future<void> fetchCategories() async {
    try {
      final categories = await _adminCategoryRepository.getAllCategories();
      allCategories.assignAll(categories);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // Fetch Authors (Admin Only)
  Future<void> fetchAuthors() async {
    try {
      final authors = await _adminAuthorRepository.getAuthors();
      allAuthors.assignAll(authors);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  // Create a New Book
  Future<void> createBook() async {
    try {
      LFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        LImages.docerAnimation,
      );

      final book = BookModel(
        id: '', // Firebase will assign the id
        title: title.text.trim(),
        description: description.text.trim(),
        isbn: isbn.text.trim(),
        price: double.parse(price.text.trim()),
        stock: int.parse(stock.text.trim()),
        author: selectedAuthor.value!,
        category: selectedCategory.value!,
        imageUrls: [], // Handle image URLs separately
        publishedDate: DateTime.now(),
        publisher: '', // Add publisher if required
        language: '', // Add language if required
        pages: 0, // Add pages if required
        rating: 0.0,
        reviewsCount: 0,
        createdAt: DateTime.now(),
        isFeatured: false,
      );

      await _adminBookRepository.createBook(book);

      // Refresh book list after creating the new book
      fetchAllBooks();
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Book added successfully!',
      );
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      LFullScreenLoader.stopLoading();
    }
  }

  // Upload Book Images
  Future<void> uploadImages() async {
    // Implement image upload logic (e.g., using Firebase Storage or Supabase)
  }
}
