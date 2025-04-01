import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/cart/widgets/l_cart_addremove.dart';

import '../../../../../common/widgets/products/product_cards/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/cart_controller.dart';
import 'l_cart_item.dart';

class LCartItems extends StatelessWidget {
  const LCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder:
            (_, __) => const SizedBox(height: LSizes.spaceBtwSections),
        itemBuilder:
            (_, index) => Obx(() {
              final item = cartController.cartItems[index];

              return Column(
                children: [
                  // Cart Item
                  LCartItem(cartItem: item),
                  if (showAddRemoveButtons)
                    const SizedBox(height: LSizes.spaceBtwItems),

                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            /// Extra Space
                            SizedBox(width: 70),

                            /// Add Remove Buttons
                            LProductQuantityWithAddOrRemoveButton(
                              quantity: item.quantity,
                              add: () => cartController.addOneToCart(item),
                              remove:
                                  () => cartController.removeOneFromCart(item),
                            ),
                          ],
                        ),

                        /// Total Product Price
                        Row(
                          children: [
                            const Text('Total: '),
                            const SizedBox(width: LSizes.sm),
                            LProductPriceText(
                              price: (item.price * item.quantity)
                                  .toStringAsFixed(1),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              );
            }),
      ),
    );
  }
}
