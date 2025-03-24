import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/data/repositories/books/book_repository.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

class BookController extends GetxController {
  static BookController get instance => Get.find();

  final isLoading = false.obs;
  final _bookRepository = Get.put(BookRepository());
  final RxList<BookModel> allBooks = <BookModel>[].obs;
  final RxList<BookModel> featuredBooks = <BookModel>[].obs;
  final RxList<BookModel> searchResults = <BookModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedBooks();
    super.onInit();
  }

  /// Fetch Featured Books
  Future<void> fetchFeaturedBooks() async {
    try {
      // show loader while loading products
      isLoading.value = true;

      // Fetch Books
      final books = await _bookRepository.getFeaturedBooks();

      // Assign Books
      featuredBooks.assignAll(books);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Search Books
  Future<void> searchBooks(String query) async {
    try {
      isLoading.value = true;
      final results = await _bookRepository.searchBooks(query);
      searchResults.assignAll(results);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Search Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Book by ID
  BookModel? getBookById(String id) {
    try {
      return allBooks.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}
