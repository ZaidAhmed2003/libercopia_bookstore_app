import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/models/book_model.dart';
import '../../../../features/shop/controllers/wishlist_controller.dart';
import '../../../widgets/icons/l_circular_icon.dart';

class LFavouriteIcon extends StatelessWidget {
  final BookModel book;

  const LFavouriteIcon({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Positioned(
      top: 0,
      right: 0,
      child: Obx(() {
        final isInWishlist = controller.wishlistBookIds.contains(book.id);

        return GestureDetector(
          onTap: () => controller.toggleWishlist(book.id),
          child: LCircularIcon(
            icon: isInWishlist ? Iconsax.heart5 : Iconsax.heart,
            color: isInWishlist ? Colors.red : Colors.grey,
          ),
        );
      }),
    );
  }
}
