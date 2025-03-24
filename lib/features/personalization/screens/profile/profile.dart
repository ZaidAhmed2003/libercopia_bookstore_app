import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/common/widgets/images/l_circular_image.dart';
import 'package:libercopia_bookstore_app/common/widgets/texts/section_heading.dart';
import 'package:libercopia_bookstore_app/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:libercopia_bookstore_app/utils/constants/enums.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: const LAppbar(showBackArrow: true, title: Text('Profile')),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : LImages.user;
                      return LCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        imageType:
                            networkImage.isNotEmpty
                                ? ImageType.network
                                : ImageType.asset,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: LSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: LSizes.spaceBtwItems),
              const LSectionHeading(title: 'Profile Information'),
              const SizedBox(height: LSizes.spaceBtwItems),

              LProfileMenu(
                onPressed: () => Get.to(() => const ChangeNameScreen()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              LProfileMenu(
                onPressed: () {},
                title: 'Username',
                value: controller.user.value.username,
              ),

              const SizedBox(height: LSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: LSizes.spaceBtwItems),

              const LSectionHeading(title: 'Personal Information'),
              const SizedBox(height: LSizes.spaceBtwItems),

              LProfileMenu(
                onPressed: () {},
                title: 'User ID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              LProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              LProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              LProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              LProfileMenu(
                onPressed: () {},
                title: 'Date of Birth',
                value: '2003-04-14',
              ),

              const Divider(),
              const SizedBox(height: LSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LProfileMenu extends StatelessWidget {
  const LProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34,
  });

  final VoidCallback onPressed;
  final String title, value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: LSizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Expanded(
              flex: 4,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: 18)),
          ],
        ),
      ),
    );
  }
}
