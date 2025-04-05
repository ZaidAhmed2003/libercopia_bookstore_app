import 'package:flutter/material.dart';
import 'package:libercopia_bookstore_app/admin/screens/books/widgets/add_book_form.dart';
import 'package:libercopia_bookstore_app/common/widgets/appbar/appbar.dart';

import '../../../../../utils/constants/sizes.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: LAppbar(title: Text('Add Book'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(LSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Form
              AddBookForm(),
            ],
          ),
        ),
      ),
    );
  }
}
