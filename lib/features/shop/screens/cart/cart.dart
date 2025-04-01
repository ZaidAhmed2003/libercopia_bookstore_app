import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/features/shop/controllers/cart_controller.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/cart/widgets/l_cart_items.dart';
import 'package:libercopia_bookstore_app/navigation_menu.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/loaders/animation_loader.dart';

import '../../../../utils/constants/image_strings.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: LAppbar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Obx(() {
        final emptyWidget = LAnimationLoaderWidget(
          text: 'Whoops! Cart is Empty.',
          animation: LImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s Fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(LSizes.defaultSpace),

              // Item In Cart
              child: LCartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar:
          controller.cartItems.isEmpty
              ? const SizedBox()
              : Padding(
                padding: const EdgeInsets.all(LSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(
                    () => Text(
                      'Checkout \$ ${controller.totalAmount.value.toStringAsFixed(1)}',
                    ),
                  ),
                ),
              ),
    );
  }
}
