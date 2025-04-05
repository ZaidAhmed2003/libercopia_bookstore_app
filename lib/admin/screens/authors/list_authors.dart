import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/admin/controller/admin_author_controller.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';
import 'package:libercopia_bookstore_app/utils/constants/sizes.dart';

import '../../../utils/constants/image_strings.dart';
import 'add_author.dart';

class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminAuthorController());

    return Scaffold(
      appBar: LAppbar(title: const Text('Authors')),

      body: Padding(
        padding: EdgeInsets.all(LSizes.defaultSpace),
        child: Obx(() {
          if (controller.authors.isEmpty) {
            return const Center(
              child: Text(
                'No authors found. Please add an author.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.authors.length,
            itemBuilder: (_, index) {
              final author = controller.authors[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        author.photoUrl.isNotEmpty
                            ? Image.network(
                              author.photoUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorBuilder:
                                  (_, __, ___) => Image.asset(
                                    LImages.user,
                                    width: 50,
                                    height: 50,
                                  ),
                            )
                            : Image.asset(LImages.user, width: 50, height: 50),
                  ),
                  title: Text(
                    author.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    author.bio.isNotEmpty
                        ? author.bio
                        : 'No biography available',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        // Get.to(() => AddAuthorScreen(author: author))
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () => controller.deleteAuthor(author.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddAuthorScreen()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
