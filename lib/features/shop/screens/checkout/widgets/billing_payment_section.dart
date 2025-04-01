import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/containers/rounded_container.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/shop/controllers/checkout_controller.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    final dark = LHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        LSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: LSizes.spaceBtwItems / 2),

        Obx(
          () => Row(
            children: [
              LRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? LColors.light : LColors.white,
                padding: const EdgeInsets.all(LSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: LSizes.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
