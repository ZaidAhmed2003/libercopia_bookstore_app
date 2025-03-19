import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/features/authentication/controllers/onboarding/onboarding.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: LDeviceUtils.getAppBarHeight(),
      right: LSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text(LTexts.skip),
      ),
    );
  }
}
