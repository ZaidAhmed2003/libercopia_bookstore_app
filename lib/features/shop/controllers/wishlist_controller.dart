import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/repositories/wishlist/wishlist_repository.dart';
import 'package:libercopia_bookstore_app/features/shop/controllers/book_controllers.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/models/book_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final _wishlistRepository = Get.put(WishlistRepository());
  final _bookController = Get.put(BookController());
  final RxList<String> wishlistBookIds = <String>[].obs;
  final RxList<BookModel> wishlistBooks = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _wishlistRepository.getWishlistStream().listen((wishlistItems) {
      wishlistBookIds.value = wishlistItems.map((item) => item.bookId).toList();
      _loadWishlistBooks();
    });
  }

  Future<void> _loadWishlistBooks() async {
    try {
      final books = await Future.wait(
        wishlistBookIds.map(
          (bookId) async => _bookController.getBookById(bookId),
        ),
      );
      wishlistBooks.value = books.whereType<BookModel>().toList();
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> toggleWishlist(String bookId) async {
    try {
      final isInWishlist = await _wishlistRepository.isBookInWishlist(bookId);
      if (isInWishlist) {
        final wishlistItem = await _wishlistRepository.getWishlistItem(bookId);
        if (wishlistItem != null) {
          await _wishlistRepository.removeFromWishlist(wishlistItem.id);
          LLoaders.successSnackBar(title: 'Removed from Wishlist');
        }
      } else {
        await _wishlistRepository.addToWishlist(bookId);
        LLoaders.successSnackBar(title: 'Added to Wishlist');
      }
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
