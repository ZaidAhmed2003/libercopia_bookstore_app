import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/author_model.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/repositories/author/author_repository.dart';

class AuthorController extends GetxController {
  static AuthorController get instance => Get.find();

  final _authorRepository = Get.put(AuthorRepository());
  final Rx<AuthorModel> currentAuthor = AuthorModel.empty().obs;
  final RxList<BookModel> authorBooks = <BookModel>[].obs;
  final isLoading = false.obs;

  /// Load Author Details
  Future<void> loadAuthorDetails(String authorId) async {
    try {
      isLoading.value = true;
      final author = await _authorRepository.getAuthorById(authorId);
      final books = await _authorRepository.getBooksByAuthor(authorId);

      currentAuthor.value = author;
      authorBooks.assignAll(books);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
