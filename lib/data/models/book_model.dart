import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  String title;
  String description;
  String isbn;
  double price;
  int stock;
  String authorId;
  List<String> categoryIds;
  List<String> imageUrls;
  DateTime publishedDate;
  String publisher;
  String language;
  int pages;
  double rating;
  DateTime createdAt;
  bool isFeatured;

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isbn,
    required this.price,
    required this.stock,
    required this.authorId,
    required this.categoryIds,
    required this.imageUrls,
    required this.publishedDate,
    required this.publisher,
    required this.language,
    required this.pages,
    required this.rating,
    required this.createdAt,
    this.isFeatured = false,
  });

  /// Creates a copy of the BookModel with updated values
  BookModel copyWith({
    String? id,
    String? title,
    String? description,
    String? isbn,
    double? price,
    int? stock,
    String? authorId,
    List<String>? categoryIds,
    List<String>? imageUrls,
    DateTime? publishedDate,
    String? publisher,
    String? language,
    int? pages,
    double? rating,
    DateTime? createdAt,
    bool? isFeatured,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isbn: isbn ?? this.isbn,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      authorId: authorId ?? this.authorId,
      categoryIds: categoryIds ?? List.from(this.categoryIds),
      imageUrls: imageUrls ?? List.from(this.imageUrls),
      publishedDate: publishedDate ?? this.publishedDate,
      publisher: publisher ?? this.publisher,
      language: language ?? this.language,
      pages: pages ?? this.pages,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  /// Empty Helper Function
  static BookModel empty() => BookModel(
    id: '',
    title: '',
    description: '',
    isbn: '',
    price: 0,
    stock: 0,
    authorId: '',
    categoryIds: [],
    imageUrls: [],
    publishedDate: DateTime.now(),
    publisher: '',
    language: '',
    pages: 0,
    rating: 0,
    createdAt: DateTime.now(),
    isFeatured: false,
  );

  factory BookModel.fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return BookModel(
        id: snapshot.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        isbn: data['isbn'] ?? '',
        price: (data['price'] as num).toDouble(),
        stock: data['stock'] ?? 0,
        authorId: data['authorId'] ?? '',
        categoryIds: List<String>.from(data['categoryIds'] ?? []),
        imageUrls: List<String>.from(data['imageUrls'] ?? []),
        publishedDate: (data['publishedDate'] as Timestamp).toDate(),
        publisher: data['publisher'] ?? '',
        language: data['language'] ?? '',
        pages: data['pages'] ?? 0,
        rating: (data['rating'] as num).toDouble(),
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return BookModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isbn': isbn,
      'price': price,
      'stock': stock,
      'authorId': authorId,
      'categoryIds': categoryIds,
      'imageUrls': imageUrls,
      'publishedDate': Timestamp.fromDate(publishedDate),
      'publisher': publisher,
      'language': language,
      'pages': pages,
      'rating': rating,
      'createdAt': Timestamp.fromDate(createdAt),
      'isFeatured': isFeatured,
    };
  }
}
