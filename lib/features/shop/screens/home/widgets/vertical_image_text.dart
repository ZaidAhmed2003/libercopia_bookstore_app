import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class LVerticalImageText extends StatelessWidget {
  const LVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = LColors.white,
    this.backgroundColor = LColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: LSizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular Icon
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(LSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ??
                    (LHelperFunctions.isDarkMode(context)
                        ? LColors.black
                        : LColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  // color: LColors.dark,
                ),
              ),
            ),

            const SizedBox(height: LSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
