import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/data/repositories/wishlist/wishlist_repository.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import 'book_controllers.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final _wishlistRepository = Get.put(WishlistRepository());
  final _bookController = Get.put(BookController());

  /// Store wishlist book IDs
  final RxSet<String> wishlistBookIds = <String>{}.obs;

  /// Store full book details
  final RxList<BookModel> wishlistBooks = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  /// Fetch wishlist from Firestore
  void _loadWishlist() {
    _wishlistRepository.getWishlistStream().listen((wishlistItems) async {
      final newWishlistIds = wishlistItems.map((item) => item.bookId).toSet();
      wishlistBookIds.value = newWishlistIds;

      // Fetch book details for all wishlist items
      List<BookModel> books = [];
      for (var bookId in newWishlistIds) {
        final book = await _bookController.getBookById(bookId);
        if (book != null) books.add(book);
      }

      wishlistBooks.assignAll(books);
    });
  }

  /// Check if a book is in the wishlist
  bool isBookInWishlist(String bookId) => wishlistBookIds.contains(bookId);

  /// Toggle wishlist state (add/remove)
  Future<void> toggleWishlist(String bookId) async {
    try {
      if (isBookInWishlist(bookId)) {
        await _wishlistRepository.removeFromWishlist(bookId);
        LLoaders.customToast(message: 'Book removed from wishlist');
      } else {
        await _wishlistRepository.addToWishlist(bookId);
        LLoaders.customToast(message: 'Book added to wishlist');
      }
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
