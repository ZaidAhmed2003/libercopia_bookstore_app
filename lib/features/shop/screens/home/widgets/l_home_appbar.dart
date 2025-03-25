import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/utils/constants/colors.dart';

import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../personalization/controllers/user_controller.dart';
import 'cart_counter_icon.dart';

class LHomeAppBar extends StatelessWidget {
  const LHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return LAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: LColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const LShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: LColors.white),
              );
            }
          }),
        ],
      ),
      actions: [LCartCounterIcon(iconColor: LColors.white)],
    );
  }
}
