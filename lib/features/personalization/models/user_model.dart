import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libercopia_bookstore_app/utils/formatters/formatter.dart';

/// Model For representing User
class UserModel {
  // Keep those value final which you don't want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  // Constructor For Model
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper Function To get Full Name
  String get fullName => '$firstName $lastName';

  /// Helper Function To Format PhoneNumber
  String get formattedPhoneNumber => LFormatter.formatPhoneNumber(phoneNumber);

  /// Static Function To split Full Name into First & Last Name
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static Function to generate username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'cwt_$camelCaseUsername';
    return usernameWithPrefix;
  }

  /// Static Function to create empty UserModel
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
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
  };

  /// Factory method to create a userModel from a firebase document snapshot
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
