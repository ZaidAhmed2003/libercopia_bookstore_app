import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/data/models/order_model.dart';
import 'package:libercopia_bookstore_app/navigation_menu.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/popups/full_screen_loader.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../common/widgets/success_screen/success_screen.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/order/order_respository.dart';
import '../../../utils/constants/enums.dart';
import '../../personalization/controllers/address_controller.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch users Order History
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await orderRepository.fetchUserOrders();
      return orders;
    } catch (e) {
      LLoaders.warningSnackBar(title: 'oh Snap!', message: e.toString());
      return [];
    }
  }

  /// ADD method for order Processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      LFullScreenLoader.openLoadingDialog(
        'Processing you order',
        LImages.pencilAnimation,
      );

      // get user id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Add Details to Order
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        items: cartController.cartItems.toList(),
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        status: OrderStatus.pending,
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
      );

      // save to firestore
      await orderRepository.saveOrder(order, userId);

      // update the cart status
      cartController.clearCart();

      // show success screen
      Get.off(
        () => SuccessScreen(
          image: LImages.orderCompletedAnimation,
          title: 'Payment Successful',
          subTitle: 'Your item will be shipped soon',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      LLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
