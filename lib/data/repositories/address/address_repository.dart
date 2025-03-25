import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/repositories/authentication/authentication_repository.dart';

import '../../models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Check if the user ID is not empty
      if (userId.isEmpty) {
        throw 'Unable to find user information, please try again later';
      }

      // Fetch the user's addresses from Firestore
      final result =
          await _db
              .collection('Users')
              .doc(userId)
              .collection('Addresses')
              .get();

      return result.docs
          .map(
            (documentSnapshot) => AddressModel.fromSnapshot(documentSnapshot),
          )
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching user addresses, Please try again later';
    }
  }

  /// Clear the "selected" field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      throw 'Something went wrong while updating the selected field';
    }
  }

  /// Add new Address
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());

      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while adding the address';
    }
  }

  /// Delete Address
  Future<void> deleteAddress(String addressId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw 'Something went wrong while deleting the address';
    }
  }
}
