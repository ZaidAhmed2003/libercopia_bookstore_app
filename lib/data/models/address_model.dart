import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libercopia_bookstore_app/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name; // e.g., "Home", "Office"
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String phoneNumber;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
    this.selectedAddress = true,
    this.dateTime,
  });

  String get formattedPhoneNumber => LFormatter.formatPhoneNumber(phoneNumber);

  /// Empty factory constructor
  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    phoneNumber: '',
  );

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'phoneNumber': phoneNumber,
      'dateTime': dateTime,
    };
  }

  /// Create AddressModel from Firestore Document
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      state: data['State'] as String,
      postalCode: data['PostalCode'] as String,
      country: data['Country'] as String,
      selectedAddress: data['selectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  /// Factory Constructor to create an AddressModel from a Firestore DocumentSnapshot
  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      selectedAddress: data['selectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return '$street , $city , $state , $postalCode , $country';
  }
}
