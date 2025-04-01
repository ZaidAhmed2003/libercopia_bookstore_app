import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libercopia_bookstore_app/utils/formatters/formatter.dart';

/// Model For representing User
class UserModel {
  // Keep those values final which you don't want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  bool isAdmin; // ✅ Added admin flag

  // Constructor For Model
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.isAdmin = false, // Default: false
  });

  /// Helper Function To get Full Name
  String get fullName => '$firstName $lastName';

  /// Helper Function To Format PhoneNumber
  String get formattedPhoneNumber => LFormatter.formatPhoneNumber(phoneNumber);

  /// Static Function To split Full Name into First & Last Name
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static Function to generate username from the full name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    return 'cwt_$firstName$lastName';
  }

  /// Static Function to create an empty UserModel
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    isAdmin: false,
  );

  /// Convert Model To Json Structure for Storing Data in Firestore
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
    'profilePicture': profilePicture,
    'isAdmin': isAdmin,
  };

  /// Factory method to create a UserModel from a Firestore document snapshot
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        isAdmin: data['isAdmin'] ?? false,
      );
    } else {
      return UserModel.empty();
    }
  }
}
