import 'package:get/get.dart';

import '../../../common/dummy_data/dummy_authors.dart';
import '../../../common/dummy_data/dummy_books.dart';
import '../../../common/dummy_data/dummy_data.dart';
import '../author/author_repository.dart';
import '../books/book_repository.dart';
import '../categories/category_repository.dart';

class DummyRepository extends GetxController {
  static DummyRepository get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());
  final authorRepository = Get.put(AuthorRepository());
  final bookRepository = Get.put(BookRepository());

  Future<void> uploadAllDummyData() async {
    // Then authors
    await authorRepository.uploadDummyAuthors(LDummyAuthors.authors);

    // First upload categories
    await categoryRepository.uploadDummyCategories(LDummyCategories.categories);

    // Finally books
    await bookRepository.uploadDummyBooks(LDummyBooks.books);
  }
}
