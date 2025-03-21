import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/device/device_utility.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/sizes.dart';

class LSearchContainer extends StatelessWidget {
  const LSearchContainer({
    super.key,
    required this.text,
    required this.icon,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = LHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LSizes.defaultSpace),
      child: Container(
        width: LDeviceUtils.getScreenWidth(context),
        padding: EdgeInsets.all(LSizes.md),
        decoration: BoxDecoration(
          color:
              showBackground
                  ? dark
                      ? LColors.dark
                      : LColors.light
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(LSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: LColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: LColors.darkerGrey),
            const SizedBox(width: LSizes.spaceBtwItems),
            Text('Search Books', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
