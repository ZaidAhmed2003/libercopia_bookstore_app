import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/dart/appbar.dart';
import 'package:libercopia_bookstore_app/common/widgets/icons/l_circular_icon.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/home.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          LCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(LSizes.defaultSpace)),
      ),
    );
  }
}
