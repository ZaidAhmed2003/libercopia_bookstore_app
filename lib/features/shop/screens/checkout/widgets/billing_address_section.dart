import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/personalization/controllers/address_controller.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),

        /// Wrap UI inside `Obx()` to listen for changes in `selectedAddress`
        Obx(() {
          final selectedAddress = addressController.selectedAddress.value;

          return selectedAddress.id.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedAddress.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.grey, size: 13),
                      const SizedBox(width: LSizes.spaceBtwItems),
                      Text(
                        selectedAddress.formattedPhoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(width: LSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_history,
                        color: Colors.grey,
                        size: 13,
                      ),
                      const SizedBox(width: LSizes.spaceBtwItems),
                      Expanded(
                        child: Text(
                          selectedAddress.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              )
              : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              );
        }),
      ],
    );
  }
}
