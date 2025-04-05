import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/personalization/screens/address/address.dart';
import 'package:libercopia_bookstore_app/navigation_menu.dart';

import '../../../../admin/admin_navigation_menu.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            Container(
              color: LColors.primary,
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  /// Appbar
                  LAppbar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: LColors.white),
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems),

                  /// User Profile Card
                  LUserProfileTile(),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(LSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Setting
                  const LSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: LSizes.spaceBtwItems),

                  LSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set Shopping Delivery Address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove & checkout items',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress, completed & cancelled orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank accounts',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Discounts',
                    subtitle: 'List of all discounted coupons',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  // App Settings
                  SizedBox(height: LSizes.spaceBtwSections),
                  const LSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),

                  SizedBox(height: LSizes.spaceBtwItems),

                  LSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'User Panel',
                    subtitle: 'Toggle User Panel And Admin Panel',
                    onTap: () => Get.to(() => NavigationMenu()),
                  ),

                  LSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Admin Panel',
                    subtitle: 'Toggle User Panel And Admin Panel',
                    onTap: () => Get.to(() => AdminNavigationMenu()),
                  ),

                  LSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to be seen',
                    onTap: () {},
                  ),

                  /// Logout Button
                  SizedBox(height: LSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          () => AuthenticationRepository.instance.logout(),
                      child: Text('Logout'),
                    ),
                  ),
                  SizedBox(height: LSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
