import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import 'add_author.dart';

class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LAppbar(title: Text('Authors')),
      body: Center(child: Text('List Authors')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddAuthorScreen()),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
