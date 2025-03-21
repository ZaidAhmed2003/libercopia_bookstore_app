import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/widgets/l_home_appbar.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/containers/search_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: LColors.primary,
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  /// Appbar
                  LHomeAppBar(),
                  const SizedBox(height: LSizes.spaceBtwSections),

                  /// Search Bar
                  LSearchContainer(
                    text: 'Search books',
                    icon: Iconsax.search_normal,
                  ),
                  const SizedBox(height: LSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(left: LSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        LSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                        ),
                        const SizedBox(height: LSizes.spaceBtwItems),

                        /// Categories List View
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return LVerticalImageText(
                                image: LImages.facebook,
                                title: 'Novel',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  image: AssetImage(image),
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
