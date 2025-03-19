import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final storage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = storage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = storage.read('REMEMBER_ME_PASSWORD') ?? '';

    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is Checked
      if (rememberMe.value) {
        storage.write('REMEMBER_ME_EMAIL', email.text.trim());
        storage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login User using Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Redirect to Home Screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      LFullScreenLoader.stopLoading();
      // Show Some Generic Error To User
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Start Loading
      LFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        LImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Redirect to Home Screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
