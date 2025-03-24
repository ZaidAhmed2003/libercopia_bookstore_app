import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/personalization/screens/address/address.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tile/settings_menu_tile.dart';
import '../../../../common/widgets/list_tile/user_profile_tile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/dummy/dummy_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyRepository = Get.put(DummyRepository());
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
                  const LSectionHeading(title: 'Account Settings'),
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
                    onTap: () {},
                  ),
                  LSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress, completed & cancelled orders',
                    onTap: () {},
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
                  const LSectionHeading(title: 'App Settings'),

                  SizedBox(height: LSizes.spaceBtwItems),
                  if (userEmail == 'zaidahmed2345@gmail.com')
                    LSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subtitle: 'Upload Data to your cloud firestore',
                      onTap: () {
                        // Show a loading indicator or some feedback to the user
                        dummyRepository.uploadAllDummyData();
                      },
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
