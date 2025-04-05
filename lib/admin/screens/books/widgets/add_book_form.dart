import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/data/models/author_model.dart';
import 'package:libercopia_bookstore_app/data/models/category_model.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../controller/admin_book_controller.dart';

class AddBookForm extends StatelessWidget {
  const AddBookForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminBookController());

    return Form(
      key: controller.addBookFormKey,
      child: Column(
        children: [
          // Book Title
          TextFormField(
            controller: controller.title,
            validator: (value) => LValidator.validateEmptyText('Title', value),
            decoration: InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(Iconsax.book),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // ISBN
          TextFormField(
            controller: controller.isbn,
            validator: (value) => LValidator.validateEmptyText('ISBN', value),
            decoration: InputDecoration(
              labelText: 'ISBN',
              prefixIcon: Icon(Iconsax.hashtag),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Price
          TextFormField(
            controller: controller.price,
            validator: (value) => LValidator.validateEmptyText('Price', value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
              prefixIcon: Icon(Iconsax.dollar_circle),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Stock
          TextFormField(
            controller: controller.stock,
            validator: (value) => LValidator.validateEmptyText('Stock', value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Stock',
              prefixIcon: Icon(Iconsax.box),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Description
          TextFormField(
            controller: controller.description,
            validator:
                (value) => LValidator.validateEmptyText('Description', value),
            decoration: InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Iconsax.message),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Category Dropdown
          DropdownButtonFormField<CategoryModel>(
            value: controller.selectedCategory.value,
            onChanged: (category) {
              controller.selectedCategory.value = category!;
            },
            items:
                controller.allCategories.map((category) {
                  return DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
            validator:
                (value) => value == null ? 'Please select a category' : null,
            decoration: InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Iconsax.tag),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Author Dropdown
          DropdownButtonFormField<AuthorModel>(
            value: controller.selectedAuthor.value,
            onChanged: (author) {
              controller.selectedAuthor.value = author!;
            },
            items:
                controller.allAuthors.map((author) {
                  return DropdownMenuItem<AuthorModel>(
                    value: author,
                    child: Text(author.name),
                  );
                }).toList(),
            validator:
                (value) => value == null ? 'Please select an author' : null,
            decoration: InputDecoration(
              labelText: 'Author',
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: LSizes.spaceBtwItems),

          // Image Picker
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
          const SizedBox(height: LSizes.spaceBtwItems),

          // Add Book Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.createBook(),
              child: const Text('Add Book'),
            ),
          ),
        ],
      ),
    );
  }
}
