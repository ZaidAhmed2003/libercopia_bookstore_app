import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class LSingleAddress extends StatelessWidget {
  const LSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);
    return LRoundedContainer(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: LSizes.sm / 2),
              const Text(
                '(+92 330 241 1283)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: LSizes.sm / 2),
              const Text(
                '82356 Timmy Coves, South Liana, Marine, Usa',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: LSizes.sm / 2),
            ],
          ),
        ],
      ),
    );
  }
}
