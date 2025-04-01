import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/repositories/authentication/authentication_repository.dart';

import '../../models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get current user's ID
  String get _userId {
    final user = AuthenticationRepository.instance.authUser;
    if (user == null) throw 'User not authenticated';
    return user.uid;
  }

  /// Fetch user addresses
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final result =
          await _db
              .collection('users')
              .doc(_userId)
              .collection('addresses')
              .orderBy('name')
              .get();

      return result.docs
          .map((snapshot) => AddressModel.fromSnapshot(snapshot))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching addresses: $e');
      }
      throw 'Failed to fetch addresses. Please try again later.';
    }
  }

  /// Update the selected address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userRef = _db
          .collection('users')
          .doc(_userId)
          .collection('addresses');

      // Use a batch to update the selected address and unselect others
      WriteBatch batch = _db.batch();

      // Unselect all addresses first
      final snapshot = await userRef.get();
      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'selectedAddress': false});
      }

      // Set the selected address to true
      batch.update(userRef.doc(addressId), {'selectedAddress': selected});

      await batch.commit();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating selected address: $e');
      }
      throw 'Failed to update the selected address. Please try again later.';
    }
  }

  /// Add a new address
  Future<String> addAddress(AddressModel address) async {
    try {
      final currentAddress = await _db
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .add(address.toJson());

      return currentAddress.id;
    } catch (e) {
      if (kDebugMode) {
        print('Error adding address: $e');
      }
      throw 'Failed to add the address. Please try again.';
    }
  }

  /// Delete an address
  Future<void> deleteAddress(String addressId) async {
    try {
      await _db
          .collection('users')
          .doc(_userId)
          .collection('addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting address: $e');
      }
      throw 'Failed to delete the address. Please try again.';
    }
  }
}
