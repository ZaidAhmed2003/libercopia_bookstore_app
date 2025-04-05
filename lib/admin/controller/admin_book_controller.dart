import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../data/models/author_model.dart';
import '../../data/models/category_model.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/network_manager.dart';
import '../../utils/popups/full_screen_loader.dart';
import '../repositories/admin_author_repository.dart';
import '../repositories/admin_book_repository.dart';
import '../repositories/admin_category_repository.dart';
import '../utils/image_upload_helper.dart';

class AdminBookController extends GetxController {
  static AdminBookController get instance => Get.find();

  final _adminBookRepository = Get.put(AdminBookRepository());
  final _adminCategoryRepository = Get.put(AdminCategoryRepository());
  final _adminAuthorRepository = Get.put(AdminAuthorRepository());
  final _imagePicker = ImagePicker();

  // Form fields
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
  var imagePath = ''.obs;
  var refreshData = false.obs;

  @override
  void onInit() {
    fetchAllBooks();
    fetchCategories();
    fetchAuthors();
    super.onInit();
  }

  Future<void> fetchAllBooks() async {
    if (allBooks.isNotEmpty) return;
    try {
      final books = await _adminBookRepository.getAllBooks();
      allBooks.assignAll(books);
      refreshData.value = !refreshData.value;
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await _adminCategoryRepository.getAllCategories();
      allCategories.assignAll(categories);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> fetchAuthors() async {
    try {
      final authors = await _adminAuthorRepository.getAuthors();
      allAuthors.assignAll(authors);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> createBook() async {
    try {
      LFullScreenLoader.openLoadingDialog(
        'Adding Book...',
        LImages.docerAnimation,
      );

      if (!await NetworkManager.instance.isConnected()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (!addBookFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (selectedCategory.value == null || selectedAuthor.value == null) {
        LLoaders.errorSnackBar(
          title: 'Error',
          message: 'Please select category and author.',
        );
        LFullScreenLoader.stopLoading();
        return;
      }

      if (imagePath.value.isEmpty) {
        LLoaders.errorSnackBar(
          title: 'Error',
          message: 'Please upload an image.',
        );
        LFullScreenLoader.stopLoading();
        return;
      }

      String? imageUrl = await SupabaseHelper.uploadImageToSupabase(
        imagePath.value,
        'book-images',
      );

      final book = BookModel(
        id: '',
        title: title.text.trim(),
        description: description.text.trim(),
        isbn: isbn.text.trim(),
        price: double.parse(price.text.trim()),
        stock: int.parse(stock.text.trim()),
        author: selectedAuthor.value!,
        category: selectedCategory.value!,
        imageUrls: ['$imageUrl'],
        publishedDate: DateTime.now(),
        publisher: '',
        language: '',
        pages: 0,
        rating: 0.0,
        reviewsCount: 0,
        createdAt: DateTime.now(),
        isFeatured: false,
      );

      await _adminBookRepository.createBook(book);

      LFullScreenLoader.stopLoading();
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Book added successfully',
      );
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
      print(e);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  // Reset all form fields

  void resetFormFields() {
    title.clear();
    isbn.clear();
    price.clear();
    stock.clear();
    description.clear();
    selectedCategory.value = null;
    selectedAuthor.value = null;
    imagePath.value = '';
    addBookFormKey.currentState?.reset();
  }

  // Delete Book
  Future<void> deleteBook(String bookId) async {
    try {
      await _adminBookRepository.deleteBook(bookId);
      allBooks.removeWhere((book) => book.id == bookId);
      allBooks.refresh();
      LLoaders.successSnackBar(
        title: 'Deleted',
        message: 'Book deleted successfully!',
      );
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
