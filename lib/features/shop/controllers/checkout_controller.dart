import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../../data/models/payment_method_model.dart';
import '../screens/checkout/widgets/payment_method_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
      name: 'Paypal',
      image: LImages.paypal,
    );
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(LSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LSectionHeading(
                    title: 'Select Payment Method',
                    showActionButton: false,
                  ),
                  const SizedBox(height: LSizes.spaceBtwSections),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Paypal',
                      image: LImages.paypal,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Google Pay',
                      image: LImages.googlePay,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay',
                      image: LImages.applePay,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Visa',
                      image: LImages.visa,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Master Card',
                      image: LImages.masterCard,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Paytm',
                      image: LImages.paytm,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Paystack',
                      image: LImages.paystack,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  PaymentMethodTile(
                    paymentMethod: PaymentMethodModel(
                      name: 'Credit Card',
                      image: LImages.creditCard,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                ],
              ),
            ),
          ),
    );
  }
}
