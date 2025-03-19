import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/features/personalization/controllers/user_controller.dart';

import '../../../features/personalization/screens/profile/profile.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/l_circular_image.dart';

class LUserProfileTile extends StatelessWidget {
  const LUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: LCircularImage(
        image: LImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.apply(color: LColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: LColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: Icon(Iconsax.edit, color: LColors.white),
      ),
    );
  }
}
