import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:libercopia_bookstore_app/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
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

  /// Convert model to JSON structure (Firestore Compatible)
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
      'dateTime': dateTime != null ? Timestamp.fromDate(dateTime!) : null,
      'selectedAddress': selectedAddress,
    };
  }

  /// Create AddressModel from Firestore Document Map
  factory AddressModel.fromMap(Map<String, dynamic> data, {String? docId}) {
    return AddressModel(
      id: docId ?? data['id'] ?? '',
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      postalCode: data['postalCode'] ?? '',
      country: data['country'] ?? '',
      selectedAddress: data['selectedAddress'] ?? false,
      dateTime: (data['dateTime'] as Timestamp?)?.toDate(),
    );
  }

  /// Create AddressModel from Firestore DocumentSnapshot
  factory AddressModel.fromSnapshot(DocumentSnapshot snapshot) {
    return AddressModel.fromMap(snapshot.data() as Map<String, dynamic>, docId: snapshot.id);
  }

  @override
  String toString() {
    return '$street, $city, $state, $postalCode, $country';
  }
}
