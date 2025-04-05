import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/personalization/controllers/address_controller.dart';
import 'package:libercopia_bookstore_app/features/shop/controllers/checkout_controller.dart';
import 'package:libercopia_bookstore_app/utils/helpers/network_manager.dart';

import '../data/repositories/user/user_repository.dart';

class GeneralBindings extends Bindings {
  final _auth = FirebaseAuth.instance;
  final _userRepo = Get.put(UserRepository());

  @override
  Future<void> dependencies() async {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
