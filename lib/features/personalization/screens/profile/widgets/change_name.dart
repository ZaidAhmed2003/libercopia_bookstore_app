import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/utils/constants/text_strings.dart';
import 'package:libercopia_bookstore_app/utils/validators/validation.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/update_name_controller.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: LAppbar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(LSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: LSizes.spaceBtwSections),

            /// Form
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator:
                        (value) =>
                            LValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: LTexts.firstName,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: LSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator:
                        (value) =>
                            LValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: InputDecoration(
                      labelText: LTexts.lastName,
                      prefixIcon: const Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: LSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
