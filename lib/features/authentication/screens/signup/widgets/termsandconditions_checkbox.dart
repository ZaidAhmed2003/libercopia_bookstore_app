import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class TermsAndConditionCheckBox extends StatelessWidget {
  const TermsAndConditionCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = LHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged:
                  (value) =>
                      controller.privacyPolicy.value =
                          !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${LTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${LTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? LColors.white : LColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? LColors.white : LColors.primary,
                ),
              ),
              TextSpan(
                text: '${LTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${LTexts.termsOfUse} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? LColors.white : LColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? LColors.white : LColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
