import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:libercopia_bookstore_app/admin/screens/authors/list_authors.dart';
import 'package:libercopia_bookstore_app/admin/screens/books/list_books.dart';
import 'package:libercopia_bookstore_app/admin/screens/categories/list_categories.dart';

import '../features/personalization/screens/settings/settings.dart';
import '../utils/helpers/helper_functions.dart';

class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController());
    final darkMode = LHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor:
              darkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),

          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.book), label: 'Books'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Authors'),
            NavigationDestination(
              icon: Icon(Iconsax.category),
              label: 'Categories',
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const ListBooksScreen(),
    const ListAuthorsScreen(),
    const ListCategoriesScreen(),
    const SettingsScreen(),
  ];
}
