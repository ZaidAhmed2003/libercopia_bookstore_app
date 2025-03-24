import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libercopia_bookstore_app/utils/popups/full_screen_loader.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/screens/login/login.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final hidePassword = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      UserModel.empty();
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save User Records From AnyRegistration Provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Convert Name To First Name and Last Name
          final nameParts = UserModel.nameParts(
            userCredential.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredential.user!.displayName ?? '',
          );

          //  Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );

          // Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      LLoaders.warningSnackBar(
        title: 'Oh Snap!',
        message:
            'Something went wrong while saving user information. you can re-save your data in your profile',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(LSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account? This action is not reversible and all your data will be permanently deleted.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: LSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete user Account
  void deleteUserAccount() async {
    try {
      LFullScreenLoader.openLoadingDialog('Processing', LImages.docerAnimation);

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          LFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          LFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong while deleting your account',
      );
    }
  }

  /// ReAuthenticate User Email And Password
  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      // Start Loader
      LFullScreenLoader.openLoadingDialog('Processing', LImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        LFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        LFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();

      // Remove Loader
      LFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      LFullScreenLoader.stopLoading();
      LLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong while deleting your account',
      );
    }
  }

  /// upload image in cloudinary
  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        LFullScreenLoader.openLoadingDialog(
          'Uploading...',
          LImages.docerAnimation,
        );

        // Upload to Supabase
        final imageUrl = await userRepository.uploadImage(image);

        // Update Firestore
        if (imageUrl != null) {
          await userRepository.updateSingleField({'profilePicture': imageUrl});
          user.update((val) {
            val?.profilePicture = imageUrl;
          });

          LLoaders.successSnackBar(
            title: 'Success',
            message: 'Profile picture updated',
          );
        }
        // Remove Loader
        LFullScreenLoader.stopLoading();
      }
    } catch (e) {
      LLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
      // Remove Loader
      LFullScreenLoader.stopLoading();
      // Namespace_code error: This error means that you're attempting to access a method or property that doesn't exist in the context where you're trying to use it.
      // In this case, this is coming from supabase side so we need to check that
    }
  }
}
