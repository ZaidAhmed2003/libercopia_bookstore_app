import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/repositories/authentication/authentication_repository.dart';
import 'package:libercopia_bookstore_app/utils/helpers/network_manager.dart';
import 'package:libercopia_bookstore_app/utils/popups/full_screen_loader.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../screens/signup/widgets/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// --SignUp
  void signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        LLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create an account you must accept the privacy policy and Terms and Use.',
        );
        LFullScreenLoader.stopLoading();
        return;
      }

      // Register User In Firebase Authentication & Store in Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // Save Authenticated User In FireStore FireStore

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);

      // Remove Loader
      LFullScreenLoader.stopLoading();

      // Show Success Message
      LLoaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your account has been created successfully. Please verify your email.',
      );

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      LFullScreenLoader.stopLoading();
      // Show Some Generic Error To User
      LLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
