import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../data/models/book_model.dart';

class LDummyBooks {
  static final List<BookModel> books = [
    BookModel(
      id: '1',
      title: 'Harry Potter and the Philosopher\'s Stone',
      description: 'The first book in the Harry Potter series',
      isbn: '9780747532743',
      price: 19.99,
      stock: 100,
      authorId: '1', // Matches J.K. Rowling's ID
      categoryIds: ['8'], // Fiction category
      imageUrls: [LImages.bookCover1],
      publishedDate: DateTime(1997, 6, 26),
      publisher: 'Bloomsbury',
      language: 'English',
      pages: 223,
      rating: 4.8,
      createdAt: DateTime.now(),
    ),
    BookModel(
      id: '2',
      title: 'Harry Potter and the Philosopher\'s Stone',
      description: 'The first book in the Harry Potter series',
      isbn: '9780747532743',
      price: 19.99,
      stock: 100,
      authorId: '1', // Matches J.K. Rowling's ID
      categoryIds: ['8'], // Fiction category
      imageUrls: [LImages.bookCover1],
      publishedDate: DateTime(1997, 6, 26),
      publisher: 'Bloomsbury',
      language: 'English',
      pages: 223,
      rating: 4.8,
      createdAt: DateTime.now(),
    ),
    BookModel(
      id: '3',
      title: 'Harry Potter and the Philosopher\'s Stone',
      description: 'The first book in the Harry Potter series',
      isbn: '9780747532743',
      price: 19.99,
      stock: 100,
      authorId: '1', // Matches J.K. Rowling's ID
      categoryIds: ['8'], // Fiction category
      imageUrls: [LImages.bookCover1],
      publishedDate: DateTime(1997, 6, 26),
      publisher: 'Bloomsbury',
      language: 'English',
      pages: 223,
      rating: 4.8,
      createdAt: DateTime.now(),
    ),
    BookModel(
      id: '4',
      title: 'Harry Potter and the Philosopher\'s Stone',
      description: 'The first book in the Harry Potter series',
      isbn: '9780747532743',
      price: 19.99,
      stock: 100,
      authorId: '1', // Matches J.K. Rowling's ID
      categoryIds: ['8'], // Fiction category
      imageUrls: [LImages.bookCover1],
      publishedDate: DateTime(1997, 6, 26),
      publisher: 'Bloomsbury',
      language: 'English',
      pages: 223,
      rating: 4.8,
      createdAt: DateTime.now(),
    ),
    // Add more books
  ];
}
