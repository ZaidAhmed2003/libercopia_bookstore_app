import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/author_model.dart';
import 'package:libercopia_bookstore_app/data/models/book_model.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/repositories/author/author_repository.dart';

class AuthorController extends GetxController {
  static AuthorController get instance => Get.find();

  final _authorRepository =
      Get.find<AuthorRepository>(); // Lazy load repository
  final Rx<AuthorModel> currentAuthor = AuthorModel.empty().obs;
  final RxList<BookModel> authorBooks = <BookModel>[].obs;
  final isLoading = false.obs;

  /// Load Author Details
  Future<void> loadAuthorDetails(String authorId) async {
    if (currentAuthor.value.id == authorId && authorBooks.isNotEmpty) {
      return; // Prevent redundant calls
    }

    try {
      isLoading.value = true;

      final authorFuture = _authorRepository.getAuthorById(authorId);
      final booksFuture = _authorRepository.getBooksByAuthor(authorId);

      final results = await Future.wait([authorFuture, booksFuture]);

      currentAuthor.value = results[0] as AuthorModel;
      authorBooks.assignAll(results[1] as List<BookModel>);
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
