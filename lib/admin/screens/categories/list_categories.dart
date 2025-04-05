import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../controller/admin_category_controller.dart';
import 'add_category.dart';

class ListCategoriesScreen extends StatelessWidget {
  const ListCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminCategoryController());

    return Scaffold(
      appBar: LAppbar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Obx(() {
            if (controller.categories.isEmpty) {
              return const Center(child: Text('No categories found'));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.categories.length,
              itemBuilder: (_, index) {
                final category = controller.categories[index];
                return ListTile(
                  leading:
                      category.image != null
                          ? SizedBox(child: Image.network(category.image))
                          : const Icon(Icons.image),

                  title: Text(category.name),
                  subtitle: Text(
                    category.isFeatured
                        ? 'Featured Category'
                        : 'Regular Category',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => controller.deleteCategory(category.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddCategoryScreen()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
