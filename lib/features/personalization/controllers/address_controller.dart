import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/personalization/screens/address/add_new_address.dart';

import '../../../data/models/address_model.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/loaders/circular_loader.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user-specific addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();

      if (addresses.isNotEmpty) {
        selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty(),
        );
      }

      return addresses;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching addresses: $e');
      }
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to fetch addresses',
      );
      return [];
    }
  }

  /// Select an address and update Firestore
  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const LCircularLoader(),
      );

      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(newSelectedAddress.id, true);

      Get.back(); // Close loader
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting address: $e');
      }
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to select address',
      );
    }
  }

  /// Add a new address
  Future<void> addNewAddress() async {
    try {
      LFullScreenLoader.openLoadingDialog(
        'Saving Address',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      if (!await NetworkManager.instance.isConnected()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;

      await selectAddress(address);

      LFullScreenLoader.stopLoading();
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Address added successfully',
      );

      refreshData.toggle();
      resetFormFields();
      Get.back();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding address: $e');
      }
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Error', message: 'Failed to add address');
    }
  }

  /// Show address selection modal
  Future<void> selectNewAddressPopup(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                FutureBuilder<List<AddressModel>>(
                  future: allUserAddresses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No addresses found'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder:
                          (_, index) => GestureDetector(
                            onTap: () async {
                              await selectAddress(snapshot.data![index]);
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(snapshot.data![index].toString()),
                            ),
                          ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.to(() => AddNewAddressScreen()),
                  child: const Text('Add New Address'),
                ),
              ],
            ),
          ),
    );
  }

  /// Delete an address
  Future<void> deleteAddress(String id) async {
    try {
      // Start Loading
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const LCircularLoader(),
      );

      await addressRepository.deleteAddress(id);

      refreshData.toggle();
      Get.back(); // Close loader
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting address: $e');
      }
      LLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to delete address',
      );
    }
  }

  /// Reset Form Fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState!.reset();
  }
}
