import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/data/models/address_model.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/address_controller.dart';

class LSingleAddress extends StatelessWidget {
  const LSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);

    final controller = AddressController.instance;

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: .25,

          children: [
            SlidableAction(
              onPressed: (_) => controller.deleteAddress(address.id),
              backgroundColor: dark ? LColors.black : LColors.white,
              foregroundColor: Colors.red,
              icon: Iconsax.trash,
              label: 'Delete',
            ),
          ],
        ),

        child: InkWell(
          onTap: onTap,
          child: LRoundedContainer(
            width: double.infinity,
            showShadow: false,
            showBorder: true,
            backgroundColor:
                selectedAddress
                    ? LColors.primary.withOpacity(0.6)
                    : Colors.transparent,
            borderColor:
                selectedAddress
                    ? Colors.transparent
                    : dark
                    ? LColors.darkerGrey
                    : LColors.grey,
            margin: EdgeInsets.only(bottom: LSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 5,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color:
                        selectedAddress
                            ? dark
                                ? LColors.light
                                : LColors.dark
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: LSizes.sm / 2),
                      Text(
                        address.formattedPhoneNumber,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: LSizes.sm / 2),
                      Text(
                        address.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: LSizes.sm / 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
