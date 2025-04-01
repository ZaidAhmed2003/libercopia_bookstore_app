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
  final Rxn<BookModel> selectedBook = Rxn<BookModel>();

  @override
  void onInit() {
    fetchAllBooks();
    fetchFeaturedBooks();
    super.onInit();
  }

  /// Fetch All Books (Used for Searching & Book Details)
  Future<void> fetchAllBooks() async {
    if (allBooks.isNotEmpty) return; // Prevent duplicate fetches
    try {
      isLoading.value = true;
      final books = await _bookRepository.getAllBooks();
      allBooks.assignAll(books);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch Featured Books with Pagination
  Future<void> fetchFeaturedBooks({int limit = 4}) async {
    try {
      isLoading.value = true;
      final books = await _bookRepository.getFeaturedBooks(limit: limit);
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

  /// Get Book by ID (Fetch if not in local state)
  Future<BookModel?> getBookById(String id) async {
    try {
      // Check if the book is already in the list
      final existingBook = allBooks.firstWhereOrNull((book) => book.id == id);
      if (existingBook != null) return existingBook;

      // Fetch from Firestore if not found in memory
      isLoading.value = true;
      final book = await _bookRepository.getBookById(id);
      if (book != null) {
        allBooks.add(book); // Cache it locally
      }
      return book;
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Book Not Found', message: e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
