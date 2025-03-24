import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';
import 'package:libercopia_bookstore_app/utils/constants/text_strings.dart';
import 'package:libercopia_bookstore_app/utils/validators/validation.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../controllers/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: LAppbar(title: Text('Re-Authentication')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: LValidator.validateEmail,
                  decoration: const InputDecoration(
                    labelText: LTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const SizedBox(height: LSizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        () => controller.reAuthenticateEmailAndPassword(),
                    child: const Text('Re-Authenticate'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
