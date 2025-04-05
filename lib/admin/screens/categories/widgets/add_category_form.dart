import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/admin/controller/admin_category_controller.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminCategoryController());

    return Form(
      key: controller.addCategoryFormKey,
      child: Column(
        children: [
          // Category Name
          TextFormField(
            controller: controller.name,
            validator:
                (value) => LValidator.validateEmptyText('Category Name', value),
            decoration: InputDecoration(
              labelText: 'Category Name',
              prefixIcon: const Icon(Iconsax.category),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwSections),

          // Category Image Picker
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Obx(
              () => Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    controller.imagePath.value.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            controller.imagePath.value.toString(),
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
          const SizedBox(height: LSizes.spaceBtwSections),

          // Add Category Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.addCategory(),
              child: const Text('Add Category'),
            ),
          ),
        ],
      ),
    );
  }
}
