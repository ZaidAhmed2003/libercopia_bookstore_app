import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/features/shop/screens/home/widgets/vertical_image_text.dart';

import '../../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/category_controller.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const CategoryShimmer();

      if (categoryController.allCategories.isEmpty) {
        return Center(
          child: Text(
            'No Categories Found',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: LColors.white),
          ),
        );
      }

      return SizedBox(
        height: 85,
        child: ListView.builder(
          itemCount: categoryController.allCategories.length,
          scrollDirection: Axis.horizontal,

          shrinkWrap: true,
          itemBuilder: (_, index) {
            final category = categoryController.allCategories[index];

            return LVerticalImageText(
              image: category.image,
              title: category.name,
              // onTap: ()=> Get.to(() => const SubCategoryScreen();
            );
          },
        ),
      );
    });
  }
}
