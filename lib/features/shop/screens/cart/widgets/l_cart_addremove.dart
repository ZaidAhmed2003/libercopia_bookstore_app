import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/icons/l_circular_icon.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

class LProductQuantityWithAddOrRemoveButton extends StatelessWidget {
  const LProductQuantityWithAddOrRemoveButton({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });

  final int quantity;
  final VoidCallback add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: LSizes.md,
          color:
              LHelperFunctions.isDarkMode(context)
                  ? LColors.white
                  : LColors.black,
          backgroundColor:
              LHelperFunctions.isDarkMode(context)
                  ? LColors.darkerGrey
                  : LColors.light,
          onPressed: remove,
        ),

        const SizedBox(width: LSizes.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: LSizes.spaceBtwItems),

        LCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: LSizes.md,
          color: LColors.white,
          backgroundColor: LColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
