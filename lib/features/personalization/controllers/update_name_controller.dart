import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/personalization/controllers/user_controller.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/profile/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  // init user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Update users first name and last name
      Map<String, dynamic> name = {
        'firstName': firstName.text.trim(),
        'lastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // update the rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Show Success Message
      LLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated successfully.',
      );

      // Move to Previous Screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // Remove Loader
      LFullScreenLoader.stopLoading();
      // Show Some Generic Error To User
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
