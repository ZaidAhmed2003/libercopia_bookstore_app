import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/icons/l_circular_icon.dart';

import '../../../../features/shop/controllers/wishlist_controller.dart';

class LFavouriteIcon extends StatelessWidget {
  const LFavouriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Positioned(
      top: 0,
      right: 0,
      child: const LCircularIcon(icon: Iconsax.heart5, color: Colors.red),
    );
  }
}
