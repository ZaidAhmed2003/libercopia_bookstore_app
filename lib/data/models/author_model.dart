import 'package:cloud_firestore/cloud_firestore.dart';

class AuthorModel {
  final String id;
  final String name;
  final String bio;
  final String photoUrl; // No longer nullable
  final DateTime createdAt;

  AuthorModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.photoUrl,
    required this.createdAt,
  });

  /// Empty Helper Function
  static AuthorModel empty() => AuthorModel(
    id: '',
    name: '',
    bio: '',
    photoUrl: '',
    createdAt: DateTime.now(),
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Create AuthorModel from Firestore Document (Safe Parsing)
  factory AuthorModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>? ?? {};
    return AuthorModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      bio: data['bio'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      createdAt:
          (data['createdAt'] is Timestamp)
              ? (data['createdAt'] as Timestamp).toDate()
              : DateTime.now(), // Fallback for safety
    );
  }
}
