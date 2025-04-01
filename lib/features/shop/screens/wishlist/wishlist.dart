import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/common/widgets/layout/grid_layout.dart';
import 'package:libercopia_bookstore_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../controllers/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Scaffold(
      appBar: LAppbar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // actions: [
        //   LCircularIcon(
        //     icon: Iconsax.add,
        //     onPressed: () => Get.to(const NavigationMenu()),
        //   ),
        // ],
      ),
      body: Obx(() {
        if (controller.wishlistBooks.isEmpty) {
          return const Center(child: Text('Your wishlist is empty'));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(LSizes.defaultSpace),
              child: Column(
                children: [
                  LGridLayout(
                    itemCount: controller.wishlistBooks.length,
                    itemBuilder:
                        (_, index) => ProductCardVertical(
                          book: controller.wishlistBooks[index],
                        ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
