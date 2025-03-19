import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/features/authentication/screens/signup/widgets/termsandconditions_checkbox.dart';
import 'package:libercopia_bookstore_app/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/signup/signup_controller.dart';

class LSignupForm extends StatelessWidget {
  const LSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Add this line
        children: [
          /// First Name & Last Name
          Row(
            children: [
              Flexible(
                // Changed from Expanded to Flexible
                child: TextFormField(
                  controller: controller.firstName,
                  validator:
                      (value) =>
                          LValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: LTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: LSizes.spaceBtwInputFields),

              Flexible(
                // Changed from Expanded to Flexible
                child: TextFormField(
                  controller: controller.lastName,
                  validator:
                      (value) =>
                          LValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: LTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: LSizes.spaceBtwInputFields),

          /// Username
          Flexible(
            // Changed from Expanded to Flexible
            child: TextFormField(
              controller: controller.username,
              validator:
                  (value) => LValidator.validateEmptyText('Username', value),
              expands: false,
              decoration: InputDecoration(
                labelText: LTexts.username,
                prefixIcon: Icon(Iconsax.user_edit),
              ),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwInputFields),

          /// Email
          Flexible(
            // Changed from Expanded to Flexible
            child: TextFormField(
              controller: controller.email,
              validator: (value) => LValidator.validateEmail(value),
              expands: false,
              decoration: InputDecoration(
                labelText: LTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwInputFields),

          /// Phone Number
          Flexible(
            // Changed from Expanded to Flexible
            child: TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => LValidator.validatePhoneNumber(value),
              expands: false,
              decoration: InputDecoration(
                labelText: LTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call),
              ),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => LValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: LTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed:
                      () =>
                          controller.hidePassword.value =
                              !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwSections),

          /// Terms & Conditions
          TermsAndConditionCheckBox(),

          const SizedBox(height: LSizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(LTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
