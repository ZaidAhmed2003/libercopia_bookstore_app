import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';

import 'add_book.dart';

class ListBooksScreen extends StatelessWidget {
  const ListBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(title: Text('Books')),
      body: Center(child: Text('List Books')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddBookScreen()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
