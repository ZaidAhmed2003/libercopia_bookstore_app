import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../../../data/models/category_model.dart';
import '../../controllers/category_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Obx(() {
        if (categoryController.allCategories.isEmpty) {
          return const Center(child: Text('No Categories Found'));
        }
        return SingleChildScrollView(
          // Make sure the whole screen is scrollable
          child: GridView.builder(
            shrinkWrap:
                true, // Prevents the GridView from occupying too much space
            padding: const EdgeInsets.all(LSizes.defaultSpace),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: categoryController.allCategories.length,
            itemBuilder: (context, index) {
              final category = categoryController.allCategories[index];
              return CategoryItem(category: category);
            },
          ),
        );
      }),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(category.image, fit: BoxFit.cover),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black12,
            ),
            child: Center(
              child: Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
