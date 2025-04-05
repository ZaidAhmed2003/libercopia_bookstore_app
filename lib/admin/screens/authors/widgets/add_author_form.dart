import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/admin/controller/admin_author_controller.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';

class AddAuthorForm extends StatelessWidget {
  const AddAuthorForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminAuthorController());

    return Form(
      key: controller.addAuthorFormKey,
      child: Column(
        children: [
          // Category Name
          TextFormField(
            controller: controller.name,
            validator:
                (value) => LValidator.validateEmptyText('Author Name', value),
            decoration: InputDecoration(
              labelText: 'Author Name',
              prefixIcon: const Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems), // Category Name
          TextFormField(
            controller: controller.bio,
            validator: (value) => LValidator.validateEmptyText('Bio', value),
            decoration: InputDecoration(
              labelText: 'Bio',
              prefixIcon: const Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwSections),

          FormField<String>(
            validator: (value) {
              if (controller.imagePath.value.isEmpty) {
                return 'Please select an image';
              }
              return null;
            },
            builder: (FormFieldState<String> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Image Picker
                  GestureDetector(
                    onTap: () => controller.pickImage(),
                    child: Obx(
                      () => Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: state.hasError ? Colors.red : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            controller.imagePath.value.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    controller.imagePath.value,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                )
                                : const Center(
                                  child: Icon(
                                    Iconsax.gallery,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              );
            },
          ),

          const SizedBox(height: LSizes.spaceBtwSections),

          // Add Category Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addAuthor(),
              child: const Text('Add Author'),
            ),
          ),
        ],
      ),
    );
  }
}
