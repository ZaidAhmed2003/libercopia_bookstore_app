import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/authentication/controllers/login/login_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class LSocialButtons extends StatelessWidget {
  const LSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: LColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              image: AssetImage(LImages.google),
              height: LSizes.iconMd,
              width: LSizes.iconMd,
            ),
          ),
        ),
        const SizedBox(width: LSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: LColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(LImages.facebook),
              height: LSizes.iconMd,
              width: LSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
