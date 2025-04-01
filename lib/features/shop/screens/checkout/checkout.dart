import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/common/widgets/containers/rounded_container.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/cart/widgets/l_cart_items.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';
import 'package:libercopia_bookstore_app/utils/helpers/pricing_calculator.dart';
import 'package:libercopia_bookstore_app/utils/popups/loaders.dart';

import '../../../../utils/constants/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);

    final cartController = CartController.instance;
    final subTotal = cartController.totalAmount.value;
    final orderController = Get.put(OrderController());
    final totalAmount = LPricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      appBar: LAppbar(
        showBackArrow: true,
        title: Text(
          'Order Preview',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            children: [
              /// Items In Cart
              const LCartItems(showAddRemoveButtons: false),
              const SizedBox(height: LSizes.spaceBtwSections),

              /// Coupon Text Field
              LCouponCode(dark: dark),
              const SizedBox(height: LSizes.spaceBtwSections),

              /// Billing Section
              LRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(LSizes.md),
                backgroundColor: dark ? LColors.black : LColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(),
                    const SizedBox(height: LSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: LSizes.spaceBtwItems),

                    /// Payment Method
                    BillingPaymentSection(),
                    const SizedBox(height: LSizes.spaceBtwItems),

                    /// Address
                    BillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(LSizes.defaultSpace),
        child: ElevatedButton(
          onPressed:
              subTotal > 0
                  ? () => orderController.processOrder(totalAmount)
                  : () => LLoaders.warningSnackBar(
                    title: 'Empty Cart',
                    message: 'Add items to cart to checkout',
                  ),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}

class LCouponCode extends StatelessWidget {
  const LCouponCode({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return LRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? LColors.dark : LColors.white,
      padding: const EdgeInsets.only(
        top: LSizes.sm,
        bottom: LSizes.sm,
        right: LSizes.sm,
        left: LSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Coupon Code',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    dark
                        ? LColors.white.withOpacity(0.5)
                        : LColors.dark.withOpacity(0.5),
                backgroundColor: Colors.grey.withOpacity(0.2),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
