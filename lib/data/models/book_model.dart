import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libercopia_bookstore_app/data/models/author_model.dart';
import 'package:libercopia_bookstore_app/data/models/category_model.dart';

class BookModel {
  final String id;
  final String title;
  final String description;
  final String isbn;
  final double price;
  final int stock;
  final AuthorModel author;
  final CategoryModel category;
  final List<String> imageUrls;
  final DateTime publishedDate;
  final String publisher;
  final String language;
  final int pages;
  final double rating;
  final int reviewsCount;
  final DateTime createdAt;
  final bool isFeatured;

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isbn,
    required this.price,
    required this.stock,
    required this.author,
    required this.category,
    required this.imageUrls,
    required this.publishedDate,
    required this.publisher,
    required this.language,
    required this.pages,
    required this.rating,
    required this.reviewsCount,
    required this.createdAt,
    required this.isFeatured,
  });

  /// Empty Helper Function
  static BookModel empty() => BookModel(
    id: '',
    title: '',
    description: '',
    isbn: '',
    price: 0.0,
    stock: 0,
    author: AuthorModel.empty(),
    category: CategoryModel.empty(),
    imageUrls: [],
    publishedDate: DateTime.now(),
    publisher: '',
    language: '',
    pages: 0,
    rating: 0.0,
    reviewsCount: 0,
    createdAt: DateTime.now(),
    isFeatured: false,
  );

  /// Convert model to JSON structure (excluding `author` object, only saving `authorId`)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isbn': isbn,
      'price': price,
      'stock': stock,
      'authorId': author.id, // Save only the `authorId` in Firestore
      'categoryId': category.id,
      'imageUrls': imageUrls,
      'publishedDate': Timestamp.fromDate(publishedDate),
      'publisher': publisher,
      'language': language,
      'pages': pages,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'isFeatured': isFeatured,
    };
  }

  /// Create `BookModel` from Firestore Document (requires fetching `AuthorModel` separately)
  factory BookModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    return BookModel(
      id: snapshot.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isbn: data['isbn'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      stock: data['stock'] ?? 0,
      author:
          AuthorModel.empty(), // Default, needs to be replaced after fetching
      category: CategoryModel.empty(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      publishedDate:
          (data['publishedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      publisher: data['publisher'] ?? '',
      language: data['language'] ?? '',
      pages: data['pages'] ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: data['reviewsCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isFeatured: data['isFeatured'] ?? false,
    );
  }
}
