import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_book_controller.dart';
import 'add_book.dart';

class ListBooksScreen extends StatelessWidget {
  const ListBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminBookController());

    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Obx(() {
        if (controller.allBooks.isEmpty) {
          return const Center(child: Text('No books available.'));
        }

        return ListView.builder(
          itemCount: controller.allBooks.length,
          itemBuilder: (context, index) {
            final book = controller.allBooks[index];
            return ListTile(
              leading:
                  book.imageUrls.isNotEmpty
                      ? Image.network(
                        book.imageUrls.first,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                      : const Icon(Icons.book),
              title: Text(book.title),
              subtitle: Text('By ${book.author.name}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteBook(book.id),
              ),
              onTap: () {
                // Optionally navigate to edit book screen
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddBookScreen()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
