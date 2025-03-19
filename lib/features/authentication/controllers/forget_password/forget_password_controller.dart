import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/popups/full_screen_loader.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Show Success Message
      LLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password'.tr,
      );

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Send Reset Password Email
  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Show Success Message
      LLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email Link Sent to Reset your Password'.tr,
      );
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
