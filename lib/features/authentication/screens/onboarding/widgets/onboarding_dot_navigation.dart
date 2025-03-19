import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/features/authentication/controllers/onboarding/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = LHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: LDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: LSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? LColors.light : LColors.dark,
          dotHeight: 6,
        ),
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick, // PageController
        count: 3,
      ),
    );
  }
}
