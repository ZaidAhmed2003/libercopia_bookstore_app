import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/loaders/circular_loader.dart';
import 'package:libercopia_bookstore_app/utils/popups/full_screen_loader.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../data/models/address_model.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/helpers/network_manager.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  final refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch all user specific addresses
  Future<List<AddressModel>> allUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();

      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );

      return addresses;
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const LCircularLoader(),
      );

      // clear the selected address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }

      // assign the new selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // set the new selected address as the selected address
      await addressRepository.updateSelectedField(newSelectedAddress.id, true);
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Error in selecting address',
        message: e.toString(),
      );
    }
  }

  /// Add new Address
  Future addNewAddress() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Storing Address',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Save Address
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

      // Update Selected Address status
      address.id = id;
      await selectAddress(address);

      // remove loader
      LFullScreenLoader.stopLoading();

      // Show Success Message
      LLoaders.successSnackBar(
        title: 'Success',
        message: 'Address added successfully',
      );

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset Fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      LFullScreenLoader.stopLoading();
      // Show Some Generic Error To User
      LLoaders.errorSnackBar(
        title: 'Address not found  ',
        message: e.toString(),
      );
    }
  }

  /// Reset Form Fields
  void resetFormFields() {
    name.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    phoneNumber.clear();
    street.clear();
    addressFormKey.currentState!.reset();
  }
}
