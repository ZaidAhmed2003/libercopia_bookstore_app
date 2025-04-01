import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/widgets/l_home_appbar.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';

import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/book_controllers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: LColors.primary,
              child: Column(
                children: [
                  /// Appbar
                  LHomeAppBar(),
                  const SizedBox(height: LSizes.spaceBtwSections),

                  /// Search Bar
                  GestureDetector(
                    onTap: () {
                      // Navigate to Search Screen
                      Get.toNamed('/search');
                    },
                    child: LSearchContainer(
                      text: 'Search books',
                      icon: Iconsax.search_normal,
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: const EdgeInsets.only(left: LSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        const LSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                        ),
                        const SizedBox(height: LSizes.spaceBtwItems),

                        /// Categories List View
                        const HomeCategories(),
                        const SizedBox(height: LSizes.spaceBtwItems),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Featured Books
            Padding(
              padding: const EdgeInsets.all(LSizes.defaultSpace),
              child: Column(
                children: [
                  FutureBuilder(
                    future: controller.fetchFeaturedBooks(limit: 4),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LVerticalProductShimmer();
                      }

                      if (controller.featuredBooks.isEmpty) {
                        return Center(
                          child: Text(
                            'No Books Found',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }

                      return LGridLayout(
                        itemCount: controller.featuredBooks.length,
                        itemBuilder:
                            (_, index) => ProductCardVertical(
                              book: controller.featuredBooks[index],
                            ),
                      );
                    },
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
